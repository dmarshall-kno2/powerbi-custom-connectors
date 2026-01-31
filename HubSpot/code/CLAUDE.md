# CLAUDE.md — HubSpot Connector

**Version:** 1.1.0 | **Last Updated:** 2026-01-14

**Project:** Kno2 HubSpot Power BI custom connector
**Location:** HubSpot/code

---

## Conductor Reference

> **This workspace inherits from the conductor hierarchy.**
> Read in order:
> 1. [`../../../CLAUDE.md`](../../../CLAUDE.md) — Conductor (root governance)
> 2. [`../../CLAUDE.md`](../../CLAUDE.md) — Power BI Connectors (project governance)
> 3. This file — HubSpot-specific rules

All environment, security, and task management rules from parent files apply here.

---

## Purpose

This file captures reporting and branding rules for AI-assisted changes.
Use it alongside AGENTS.md, CLAUSES.md, SKILLS.md, and docs/powerbi/Branding_Guide.json.

Branding rules (from brand guides)
---------------------------------
- Use "Kno2" as one word; do not abbreviate (no "K2").
- First reference to the organization name includes the registered trademark symbol (R).
- Use "Kno2 Connected" in public references to integrated products; "connected by Kno2" is acceptable.
- Ensure Kno2 Connected attribution is visible in UI and public materials; private-label partners show it at login.
- Preferred logo: full-color Kno2 icon with blue dots; alternate is full-color icon with white dots if needed.
- Maintain logo aspect ratio, clear space, and minimum sizes (print minimum 1 inch; on-screen minimum 120 px, confirm exact dimension in the brand deck).
- Use the palette and fonts from `docs/powerbi/Branding_Guide.json`.
- Approved brand messaging snippets (partnership, integrated technology, QHIN) are listed in `docs/powerbi/Branding_Guide.json`.
- When referencing third-party networks or services, follow their official brand guidance:
  - DocuSign: brand.docusign.com
  - DirectTrust: directtrust.org/resources
  - Carequality: a framework, not a network; no italicization of the "e" in plain text.
  - TEFCA: use full name "Trusted Exchange Framework and Common Agreement (TEFCA)" in plain text.

Power BI report expectations
----------------------------
- Apply `docs/powerbi/Corporate_Theme.json` (authoritative).
- Enforce `docs/powerbi/Branding_Guide.json` for metadata consistency across workspaces.
- Follow the DAR model (Executive/Manager/Individual contributor tiers).
- Keep global filters in a consistent location (prefer a collapsible left pane).
- Limit visuals to 8 or fewer per page and include custom tooltips for complex visuals.
- For executive pages, use only certified datasets validated against `Master_Metric_Dictionary.md`.
- Target < 3 seconds load time for report pages.

Sources
-------
- `docs/kno2-brand-guidelines-documents/Kno2 Connected Brand Guidelines_2025.docx`
- `docs/kno2-brand-guidelines-documents/Kno2 Brand Guidelines_June23.pptx`
- `docs/powerbi/Branding_Guide.json`
- `docs/powerbi/Corporate_Theme.json`
