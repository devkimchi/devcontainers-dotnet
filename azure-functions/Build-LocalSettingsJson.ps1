### This add the GitHub Codespaces capability to your local.settings.json

# Get the local.settings.sample.json file.
$localSettingsSampleJson = Get-ChildItem -Path $env:CODESPACE_VSCODE_FOLDER -Filter local.settings.sample.json -Recurse

# Get the local.settings.json file. If not exists, create one.
$localSettingsJson = Get-ChildItem -Path $localSettingsSampleJson.Directory.FullName -Filter local.settings.json
if ($localSettingsJson -eq $null) {
    Copy-Item -Path $localSettingsSampleJson.FullName -Destination "$($localSettingsSampleJson.Directory.Name)/local.settings.json"
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
if ($appSettings.Values.OpenApi__HostNames -eq $null) {
    $appSettings.Values | Add-Member -NotePropertyName OpenApi__HostNames -NotePropertyValue "https://$($env:CODESPACE_NAME)-7071.githubpreview.dev/api"
} else {
    $appSettings.Values.OpenApi__HostNames = "https://$($env:CODESPACE_NAME)-7071.githubpreview.dev/api," + $appSettings.Values.OpenApi__HostNames
}

# Overwrite the existing local.settings.json
$appSettings | ConvertTo-Json -Depth 100 | Out-File -Path $localSettingsJson.FullName -Force
