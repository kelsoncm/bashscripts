# Instalação em massa de apps via winget
$ErrorActionPreference = "SilentlyContinue"

# Verifica/install do winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget não encontrado. Instale o Windows Package Manager primeiro." -ForegroundColor Red
    exit 1
}

# Instalar PowerShell 7 (recomendado antes de outros apps)
Write-Host "Instalando PowerShell 7..." -ForegroundColor Green
winget install --id Microsoft.PowerShell --source winget -e --silent

if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ PowerShell 7 instalado." -ForegroundColor Green
} else {
    Write-Host "  ✗ Falha ao instalar PowerShell 7 (ExitCode=$LASTEXITCODE)" -ForegroundColor Yellow
}

# Lista de apps (ID winget) baseada nos seus nomes
$apps = @(
    "Microsoft.VisualStudioCode"             # Visual Studio Code
    # "Microsoft.PowerBI"                      # Power BI Desktop
    # "Microsoft.PowerBIReportBuilder"         # Power BI Report Builder
    "JetBrains.PyCharm"                      # PyCharm Community
    "JetBrains.PhpStorm"                     # PHPStorm
    "JetBrains.DataGrip"                     # DataGrip
    "JetBrains.DataSpell"                    # DataSpell
    "JetBrains.IntelliJIDEA"                 # IntelliJ IDEA Community
    "Python.Python.3.14"                     # Python 3.14
    "astral-sh.uv"                           # uv
    "Docker.DockerDesktop"                   # Docker Desktop
    "Git.Git"                                # Git
    "Debian.Debian"                          # Debian WSL
    "Helm.Helm"                              # helm
    "Derailed.k9s"                           # k9s
    "Mirantis.Lens"                          # Mirantis Lens
    "Mozilla.Firefox"                        # Firefox
    "Google.Chrome.EXE"                      # Chrome
    "Perplexity.Comet"                       # Comet
    "XPDBZ4MPRKNN30"                         # Opera GX
    "Readdle.Spark"                          # Spark Mail
    "VideoLAN.VLC"                           # VLC
    "Microsoft.WindowsCalculator"            # Calculadora²
    "7zip.7zip"                              # 7‑Zip
    "OpenVPNTechnologies.OpenVPNConnect"     # OpenVPN
    "Termius.Termius"                        # Termius
    "TeamViewer.TeamViewer"                  # TeamViewer
    "Microsoft.Office"                       # Microsoft Office 365
    "9PM860492SZD"                           # Microsoft PC Manager
    "Microsoft.PowerToys"                    # Microsoft PowerToys
    "WhatsApp"                               # WhatsApp
)

# Instala um app por vez
foreach ($app in $apps) {
    $appName = $app.Split(".")[-1]  # pega o nome final para legibilidade
    Write-Host "Verificando $appName..." -NoNewline

    $installed = winget list --id $app --exact -e | Select-String -Pattern $app

    if ($installed) {
        Write-Host " (já instalado)" -ForegroundColor Yellow
        continue
    }

    Write-Host " Instalando $appName..." -ForegroundColor Green
    winget install --id $app -e --silent --accept-package-agreements --accept-source-agreements `
                  --override "/SILENT" --source winget

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ $appName instalado." -ForegroundColor Green
    } else {
        Write-Host "  ✗ Falha ao instalar $appName (ExitCode=$LASTEXITCODE)" -ForegroundColor Yellow
    }
}

oh-my-posh font install Meslo
$themeDir = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes"

# Cria o diretório se não existir
if (!(Test-Path $themeDir)) { New-Item -Path $themeDir -ItemType Directory }

# Baixa o tema agnoster diretamente do repo oficial
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/agnoster.omp.json" `
                  -OutFile "$themeDir\agnoster.omp.json"


Write-Host "Instalação concluída." -ForegroundColor Cyan

