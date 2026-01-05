cd "C:\Users\***\Documents\personal-website"

while ($true) {
    Get-ChildItem -Recurse -Filter *.qmd | ForEach-Object {

        $lastWrite = $_.LastWriteTime

        if ($lastWrite -ne $_.Tag) {
            $_ | Set-ItemProperty -Name Tag -Value $lastWrite

            # Render the file
            quarto render $_.FullName

            # Compute expected HTML output path
            $relativePath = $_.FullName.Substring((Get-Location).Path.Length).TrimStart('\')
            $htmlPath = Join-Path "_site" ($relativePath -replace '\.qmd$', '.html')

            if (Test-Path $htmlPath) {
                Move-Item $htmlPath $_.DirectoryName -Force
            }
        }
    }

    Start-Sleep -Milliseconds 500
}

