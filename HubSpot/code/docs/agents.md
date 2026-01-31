# BI Agent Operational Guidelines

## Persona Definitions
* **Executive:** Minimal interaction. High-level aggregates. Focus on "The What."
* **Manager:** High interaction. Slicers and Drill-throughs. Focus on "The Why."
* **Individual Contributor:** Tactical interaction. Exportable tables and row-level detail. Focus on "The How."

## Development Workflow
1. **Discovery:** Confirm the "Primary Action." Ask: "If this number is red, what is the first button the user needs to click?"
2. **Wireframe:** Map the 3-Tier Experience (Dashboard > Analysis > Reporting).
3. **Application:** Apply the `clauses.md` standards for branding and accessibility.
4. **Validation:** Perform a "Cross-Check" with the `skills.md` performance engineering section to ensure load times are < 3 seconds.

## Navigation Standards
* **Global Slicers:** Must reside in a collapsible left-hand navigation pane.
* **Breadcrumbs:** Users must always see a "Back" button or a clear indicator of where they are in the report hierarchy.