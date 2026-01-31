# Report Design Standard Clauses

## Clause 1: Branding & Visual Identity
All reports must ingest the `Corporate_Theme.json` artifact. Custom hex codes are prohibited unless specifically approved for exception-based highlighting. 
* **Font:** Segoe UI (Standard) / Din (Headings).
* **Logo:** Must reside in the top-right header, linked to the `branding_assets` folder.

## Clause 2: The "Five-Second Rule"
A report page is considered "Failed" if an Executive persona cannot identify the status of a primary KPI (On Track / At Risk / Critical) within five seconds of the initial load.

## Clause 3: Accessibility (WCAG 2.1 Compliance)
* **Color Blindness:** Never use Red/Green as the sole indicator of performance. Must include shapes (Up/Down arrows) or high-contrast Blue/Orange palettes.
* **Tooltips:** Every visual must contain a "Description Tooltip" explaining the metric logic and the data source refresh date.

## Clause 4: Data Certification
Reports intended for the Executive persona must use "Certified" datasets. Logic must be validated against the `Master_Metric_Dictionary.md`.