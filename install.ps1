# Installation script for Super Saiyan Bug Bounty Skill (Windows/PowerShell)

$SkillDir = Join-Path $HOME ".claude\skills\super-saiyan"

Write-Host "🌟 Installing Super Saiyan Bug Bounty Skill..." -ForegroundColor Cyan

if (Test-Path $SkillDir) {
    Write-Host "⚠️ Skill directory already exists at $SkillDir" -ForegroundColor Yellow
    Write-Host "Updating existing installation..." -ForegroundColor Cyan
    Set-Location $SkillDir
    git pull
} else {
    $SkillsParentDir = Join-Path $HOME ".claude\skills"
    if (-not (Test-Path $SkillsParentDir)) {
        New-Item -ItemType Directory -Force -Path $SkillsParentDir | Out-Null
    }
    
    Write-Host "Cloning repository to $SkillDir..." -ForegroundColor Cyan
    git clone https://github.com/mridulrastogimrt02-svg/-super-saiyan-skill.git $SkillDir
}

Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host "To use this skill, simply type '/skill super-saiyan' in your AI assistant interface." -ForegroundColor White
