In powershell, run the following command.

cd "C:\Users\jarro\Documents\personal-website"

while ($true) {
    Get-ChildItem *.qmd | ForEach-Object {
        $lastWrite = $_.LastWriteTime
        if ($lastWrite -ne $_.Tag) {
            $_ | Set-ItemProperty -Name Tag -Value $lastWrite
            quarto render $_.FullName
            Move-Item "_site/*.html" "./" -Force
        }
    }
    Start-Sleep -Milliseconds 500
}
