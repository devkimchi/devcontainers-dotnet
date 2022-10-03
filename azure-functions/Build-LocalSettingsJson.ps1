### This add the GitHub Codespaces capability to your local.settings.json
Param(
    [switch]
    [Parameter(Mandatory=$false)]
    $UseNgrok,

    [switch]
    [Parameter(Mandatory=$false)]
    $Help
)

function Show-Usage {
    Write-Output "
    Usage: $(Split-Path $MyInvocation.ScriptName -Leaf) [-WithClock] [-Help]

    Options:
        -UseNgrok:  This switch indicates whether to use the ngrok URL or not
        -Help:      Show this message.

"

    Exit 0
}

# Show usage
if ($Help -eq $true) {
    Show-Usage
    Exit 0
}

function Get-CodespaceUrl {
    param (
        [string] $CodespaceName
    )

    $codespaceUrl = "https://$($CodespaceName)-7071.githubpreview.dev/api"

    return $codespaceUrl
}

function Get-NgrokUrl {
    $tunnels = $(ngrok api tunnels list | ConvertFrom-Json).tunnels
    $ngrokUrl = "$($($tunnels | Where-Object { $_.forwards_to -eq "http://localhost:7071" }).public_url)/api"

    return $ngrokUrl
}

function Get-HostUrls {
    param (
        [string] $CodespaceName,
        [bool] $UseNgrok
    )

    $ngrokUrl = $null
    $codespaceUrl = Get-CodespaceUrl -CodespaceName $CodespaceName
    $url = $codespaceUrl
    if ($UseNgrok -eq $true) {
        $ngrokUrl = Get-NgrokUrl
        $url = $ngrokUrl
    }
    $urls = @{ ngrokUrl = $ngrokUrl; codespaceUrl = $codespaceUrl; url = $url }

    return $urls
}

# Get the local.settings.sample.json file.
$localSettingsSampleJson = Get-ChildItem -Path $env:CODESPACE_VSCODE_FOLDER -Filter local.settings.sample.json -Recurse

# Get the local.settings.json file. If not exists, create one.
$localSettingsJson = Get-ChildItem -Path $localSettingsSampleJson.Directory.FullName -Filter local.settings.json
if ($localSettingsJson -eq $null) {
    Copy-Item -Path $localSettingsSampleJson.FullName -Destination "$($localSettingsSampleJson.Directory.FullName)/local.settings.json"
    $localSettingsJson = Get-ChildItem -Path $localSettingsSampleJson.Directory.FullName -Filter local.settings.json
}

# Get the app settings details.
$appSettings = Get-Content -Path $localSettingsJson.FullName | ConvertFrom-Json

# Add OpenApi__ForceHttps to local.settings.json.
if ($appSettings.Values.OpenApi__ForceHttps -eq $null) {
    $appSettings.Values | Add-Member -NotePropertyName OpenApi__ForceHttps -NotePropertyValue "true"
} else {
    $appSettings.Values.OpenApi__ForceHttps = "true"
}

# Add OpenApi__RunOnCodespaces to local.settings.json.
if ($appSettings.Values.OpenApi__RunOnCodespaces -eq $null) {
    $appSettings.Values | Add-Member -NotePropertyName OpenApi__RunOnCodespaces -NotePropertyValue "true"
} else {
    $appSettings.Values.OpenApi__RunOnCodespaces = "true"
}

# Add OpenApi__HostNames to local.settings.json.
$urls = Get-HostUrls -CodespaceName $env:CODESPACE_NAME -UseNgrok $UseNgrok
if ($appSettings.Values.OpenApi__HostNames -eq $null) {
    $appSettings.Values | Add-Member -NotePropertyName OpenApi__HostNames -NotePropertyValue $($urls.url)
} else {
    $hostNames = $appSettings.Values.OpenApi__HostNames -split ","
    $hostNames = [System.Collections.ArrayList]$hostNames

    $ngrokUrls = $hostNames | Where-Object { $_ -like "*ngrok.io/api" }
    if ($ngrokUrls.Length -gt 0) {
        $ngrokUrls | ForEach-Object { $hostNames.Remove($_) }
    }
    if ($urls.codespaceUrl -ne $null) {
        $hostNames.Remove($urls.codespaceUrl)
    }
    $hostNames.Insert(0, $urls.url)

    $appSettings.Values.OpenApi__HostNames = $($hostNames -join ",").Trim(',')
}

# Overwrite the existing local.settings.json
$appSettings | ConvertTo-Json -Depth 100 | Out-File -Path $localSettingsJson.FullName -Force
