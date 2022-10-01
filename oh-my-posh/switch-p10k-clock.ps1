Param(
    [switch]
    [Parameter(Mandatory=$false)]
    $WithClock,

    [switch]
    [Parameter(Mandatory=$false)]
    $Help
)

function Show-Usage {
    Write-Output "
    Usage: $(Split-Path $MyInvocation.ScriptName -Leaf) [-WithClock] [-Help]

    Options:
        -WithClock: This switch enables clock.
        -Help:      Show this message.

"

    Exit 0
}

# Show usage
if ($Help -eq $true) {
    Show-Usage
    Exit 0
}

# Backup p10k.omp.json
Copy-Item $HOME/p10k.omp.json $HOME/p10k.omp.json_backup -Force

# Install p10k with clock
if ($WithClock -eq $true) {
    Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] Installing theme: Powerlevel10k with clock ..."
    Copy-Item $HOME/p10k-with-clock.omp.json $HOME/p10k.omp.json -Force
}

# Install p10 without clock
else {
    Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] Installing theme: Powerlevel10k without clock ..."
    Copy-Item $HOME/p10k-without-clock.omp.json $HOME/p10k.omp.json -Force
}

Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] Switch completed. Run '. `$PROFILE' to apply changes ..."
