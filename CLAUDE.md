# CLAUDE.md — Power BI Custom Connectors

**Version:** 1.0.0 | **Last Updated:** 2026-01-14

---

## Conductor Reference

> **This workspace inherits from the conductor workspace.**
> Before proceeding, read and follow: [`../CLAUDE.md`](../CLAUDE.md)

All environment, security, and task management rules from the conductor apply here.

---

## Project Overview

**Purpose:** Custom Power BI connectors for Kno2 data integrations

This project contains Power Query (M language) connectors:

| Connector | Status | Description |
|-----------|--------|-------------|
| HubSpot | Active | CRM data integration |
| Xero | Active | Accounting data integration |
| ZendeskSupport | Active | Support ticket data integration |

**Mission Alignment:** These connectors enable seamless data flow into Power BI reports, empowering data-driven decisions that delight our customers through better insights and faster reporting.

---

## Environment (Inherited)

**Platform:** Windows 11 | **Shell:** PowerShell (NOT bash/Linux/WSL)

See conductor CLAUDE.md for full PowerShell guidance.

---

## Project-Specific CLAUDE.md Files

Some connectors have additional guidance:

- [`HubSpot/code/CLAUDE.md`](HubSpot/code/CLAUDE.md) — Branding rules, Power BI report standards

These files add to (not replace) this governance.

---

## Development Workflow

### Building Connectors

```powershell
# Navigate to connector code directory
Set-Location HubSpot\code

# Build using Power Query SDK (VS Code extension)
# Or use the build script if available
.\build-desktop.ps1

# Output: .mez file in bin\ or build\ directory
```

### Testing Connectors

1. Copy `.mez` file to `Documents\Power BI Desktop\Custom Connectors`
2. Enable custom connectors in Power BI Desktop options
3. Restart Power BI Desktop
4. Test connection via "Get Data"

---

## Security Requirements (Inherited + Enhanced)

From conductor:
- **NEVER** hardcode API keys or OAuth credentials
- Use Power BI parameters for sensitive values
- Ensure `.gitignore` excludes credential files

### Power BI Specific
- OAuth tokens must use secure redirect URIs
- Client secrets stored in Azure Key Vault (not code)
- Connector code reviewed for credential exposure before publishing

---

## Branding Standards

When creating reports or connector UIs, follow Kno2 brand guidelines:
- Use "Kno2" as one word (never "K2")
- Apply corporate color palette from `docs/powerbi/Corporate_Theme.json`
- Follow visual standards in `docs/powerbi/Branding_Guide.json`

See [`HubSpot/code/CLAUDE.md`](HubSpot/code/CLAUDE.md) for detailed branding rules.

---

## Task Management

Use **Beads** for tracking work:

```powershell
bd add "Update HubSpot connector for new API endpoints"
bd list
bd done <id>
```

---

## File Organization

```
powerbi-custom-connectors/
├── CLAUDE.md              # This file
├── README.md              # Project overview
├── LICENSE                # MIT license
├── HubSpot/
│   ├── build/             # Compiled .mez files
│   └── code/              # Source code, CLAUDE.md, docs
├── Xero/                  # Xero connector
├── ZendeskSupport/
│   ├── build/             # Compiled .mez files
│   └── code/              # Source code
└── img/                   # Documentation images
```

---

## Change Log

| Date | Change | Impact |
|------|--------|--------|
| 2026-01-14 | Created chained CLAUDE.md | Inherits conductor governance |

---

## References

- [Conductor CLAUDE.md](../CLAUDE.md) — Parent governance
- [Power Query M Reference](https://docs.microsoft.com/en-us/powerquery-m/) — Language docs
- [Custom Connector Development](https://docs.microsoft.com/en-us/power-query/samples/trippin/readme) — Tutorial
- [Kno2 Brand Guidelines](HubSpot/code/docs/kno2-brand-guidelines-documents/) — Branding assets
