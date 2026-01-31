# CLAUSES.md

Standardization rules for Power BI reports
==========================================

Branding and visual consistency
-------------------------------
- North Star rule: all reports must ingest `docs/powerbi/Corporate_Theme.json`.
- Use the Common Branding Guide JSON for metadata enforcement: `docs/powerbi/Branding_Guide.json`.
- Fonts: Segoe UI (standard text) and Din (headings). Do not introduce ad-hoc fonts.
- Custom hex colors are prohibited unless explicitly approved for exception-based highlighting.
- Use consistent iconography for navigation and information tooltips.
- Logo placement must be top-right in the header and link to the `branding_assets` folder.
- Maintain minimum logo sizes and clear space per the brand guide.

Five-second rule
----------------
- A report page fails if an Executive user cannot identify the status of the primary KPI
  (On Track, At Risk, Critical) within five seconds of initial load.
- If a visual needs a manual to interpret, simplify it or add a "How to Read" tooltip.

Accessibility and inclusion
---------------------------
- WCAG 2.1 compliance required.
- Avoid red/green combinations without a secondary indicator (shape, icon, or label).
- Prefer color-blind-safe contrasts such as blue/orange from the brand palette.
- Every visual must include a description tooltip with metric logic and "Last Refreshed" date.

Performance standards
---------------------
- Limit pages to 8 or fewer visuals.
- Favor measures and model calculations that minimize visual render time; push heavy logic to the source when possible.
- Executive tier pages must use certified datasets validated against `Master_Metric_Dictionary.md`.
