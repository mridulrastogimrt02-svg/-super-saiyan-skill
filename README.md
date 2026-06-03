# Super Saiyan Bug Bounty Skill

Ultimate consolidated bug bounty hunting skill for opencode. 160+ vulnerability sections covering web, API, mobile, cloud, LLM/AI, and infra security testing.

## Installation

We provide quick installation scripts for easy setup.

**Linux / macOS:**
```bash
curl -sSL https://raw.githubusercontent.com/mridulrastogimrt02-svg/-super-saiyan-skill/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr https://raw.githubusercontent.com/mridulrastogimrt02-svg/-super-saiyan-skill/main/install.ps1 -UseBasicParsing | iex
```

Alternatively, you can install manually:
```bash
git clone https://github.com/mridulrastogimrt02-svg/-super-saiyan-skill.git ~/.claude/skills/super-saiyan
```

Then load with: `/skill super-saiyan`

## ⚡ Quick Reference
See [CHEATSHEET.md](CHEATSHEET.md) for a condensed list of high-value triggers and patterns to keep open during your hunts.

## Sections


- 3.0-3.24: XSS (all types + bypasses)
- 3.25-3.50: Injection (SQL, NoSQL, SSTI, LDAP, XPath, CRLF)
- 3.51-3.75: Auth (OAuth, JWT, SAML, MFA, Password Reset)
- 3.76-3.100: API (GraphQL, SSRF, XXE, File Upload, Business Logic)
- 3.101-3.130: Cloud/Mobile/Infra (Lambda, Kubernetes, Electron)
- 3.131-3.159: Advanced (CSPT, RFD, SSPP, LLM, Cookie Tossing, Cache)
- Phase 1-5: Recon → Pre-Hunt → Hunt → Chain → Validate & Report

## License

MIT
