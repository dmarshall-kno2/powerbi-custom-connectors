# REFERENCES.md

Power BI best practice reference library
========================================
This library provides visual and structural benchmarks for report design across Executive, Managerial, and Tactical tiers.
Use these references to align UI/UX and storytelling with industry-leading standards.

Gold standard: interactive showcases
------------------------------------
- Microsoft Data Stories Gallery
  https://community.fabric.microsoft.com/t5/Data-Stories-Gallery/bd-p/DataStoriesGallery
  Why: Official community-voted best-in-class reports; strong navigation patterns, Z-patterns, and custom themes.
- Enterprise DNA Showcase
  https://enterprisedna.co/showcase
  Why: High-end business scenarios; excellent for Managerial-tier logic.
- NovyPro Showcase
  https://www.novypro.com/
  Why: Clean UI/UX and modern design trends (glassmorphism/flat).

Industry-specific best practices
--------------------------------
- Zebra BI Dashboard Examples
  https://zebrabi.com/power-bi-dashboard-examples/
  Best practice: The 4-question insight test; strong variance (Actual vs Budget) for Executive tier.
- Coupler.io 32-Template Library
  https://blog.coupler.io/power-bi-dashboard-examples/
  Best practice: Marketing/SEO reporting and high-volume API data layouts.

Technical and UX design guidelines
----------------------------------
- SQLBI Visuals Reference
  https://www.sqlbi.com/ref/power-bi-visuals-reference/
  Why: Chart selection guidance to match data relationships.
- Microsoft Learn Design Tips
  https://learn.microsoft.com/en-us/power-bi/create-reports/service-dashboards-design-tips
  Why: Standardized dashboard layout, tile placement, and information density.
- Aufait UX Design Principles
  https://www.aufaitux.com/blog/power-bi-dashboard-design-best-practices/
  Why: White space, typography, and visual hierarchy for Power BI canvases.

Instructions for the agent
--------------------------
When generating a report plan or visual layout:
1) Reference SQLBI to validate that the visual matches the data relationship (e.g., bullet charts for target vs actual).
2) Cross-check Zebra BI for Executive summaries so variance is visible without interaction.
3) Audit against Microsoft Design Tips to ensure the highest-priority KPI is top-left (canvas origin).
4) Perform an accessibility check using `CLAUSES.md` and confirm high-contrast examples in the Data Stories Gallery.

VS Code tip
-----------
If using the Markdown All in One or Markdown Links extension in VS Code, these URLs remain clickable for review.
