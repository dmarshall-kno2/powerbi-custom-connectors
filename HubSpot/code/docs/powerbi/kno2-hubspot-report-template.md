# Kno2 HubSpot Power BI Report Template

Purpose
-------
Provide a consistent, branded, three-tier report structure (Executive, Managerial, Individual Contributor) that bridges complex data and actionable insights.

Theme and assets
----------------
- Apply `docs/powerbi/Corporate_Theme.json` on import.
- Use colors, fonts, and logo rules in `docs/powerbi/Branding_Guide.json`.
- Keep backgrounds white and reserve yellow (#FBC908) for calls to action.

Three-tier experience (DAR)
---------------------------
Executive tier (What)
- Goal: high-level health and trends with minimal interaction.
- Visuals: KPI cards, status indicators, trend lines.
- Interaction: low; page should be readable at a glance.

Managerial tier (Why)
- Goal: uncover drivers and root causes.
- Visuals: slicers, Top N lists, bar charts, heatmaps, variance visuals.
- Interaction: moderate; includes drill-through to detailed views.

Individual contributor tier (How)
- Goal: tactical execution and auditing.
- Visuals: detail tables, row-level lists, exportable views.
- Interaction: high; filtering and exporting enabled.

Persona mapping
--------------
| Persona | Primary goal | Visual type | Interaction | Granularity |
| --- | --- | --- | --- | --- |
| Executive | Monitor health and strategy | KPI cards, gauges | Very low (static or email) | Annual or quarterly |
| Manager | Identify trends and bottlenecks | Bar charts, heatmaps | Moderate (slicing, drill) | Monthly or weekly |
| Individual contributor | Task execution and audit | Pivot tables, detail lists | High (exporting, filtering) | Daily or transaction-level |

Page layout guidance
--------------------
- Global filters: left collapsible pane used consistently across pages.
- Navigation: page titles, breadcrumbs, and next/previous buttons on every page.
- Visual count: 8 or fewer visuals per page to preserve performance.
- Visual hierarchy: place most critical KPIs in the top-left (Z-pattern/F-pattern).

Page templates
--------------
Executive overview (Page 1)
- Row 1: 3-5 KPI cards (status icon + delta vs prior period).
- Row 2: primary trend line and a small variance visual.
- Row 3: 2 supporting KPIs or a compact summary table.
- Tooltip: mini trend line and last refresh date for each KPI.

Managerial analysis (Page 2)
- Left pane: slicers for time, region, product, segment.
- Main: Top N bar chart, heatmap by category, waterfall or variance chart.
- Drill-through: link to row-level details page.

Individual contributor details (Page 3)
- Full-width table with key attributes and status.
- Optional detail cards for selected row.
- Export-friendly layout with clear column naming.

Tooltips and accessibility
--------------------------
- Provide custom tooltips for any complex visual, including definitions and last refresh date.
- Avoid red/green without secondary indicators (icons or labels).
- Use blue/orange contrasts from the brand palette for status signals.

Performance and data standards
------------------------------
- Push heavy calculations to the model or data source when possible.
- Use certified datasets for executive pages.
- Validate measures against `Master_Metric_Dictionary.md`.
- Target < 3 seconds page load time.

Notes
-----
- Confirm logo size and placement per the brand deck.
- If data changes require new drill-throughs, ensure the "So What" action is available.
