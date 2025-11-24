# Instale o winget se não estiver disponível (Windows Package Manager)
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    # Baixe o instalador de winget
    Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" `
                      -OutFile "$env:TEMP\DesktopAppInstaller.msixbundle"
    Add-AppPackage -Path "$env:TEMP\DesktopAppInstaller.msixbundle"
}

# Instale MSYS2 via winget
winget install --id MSYS2.MSYS2 --accept-package-agreements --accept-source-agreements

# Aguarde e obtenha o caminho de instalação padrão do MSYS2
$msys2Path = "C:\msys64"

# Instale Zsh pelo pacman do MSYS2 (mingw64)
Start-Process -FilePath "$msys2Path\usr\bin\bash.exe" -ArgumentList "-lc 'pacman -Sy --noconfirm zsh'" -Wait
