# AGENTS.md

Project: Kno2 HubSpot Power BI custom connector
Location: HubSpot/code

Purpose
-------
This connector exposes HubSpot CRM objects to Power BI using a custom connector
implemented in `HubSpot.pq`.

Key files
---------
- `HubSpot.pq`: Connector logic and navigation tables.
- `README.md`: Build/test steps and object list.
- `build-desktop.ps1`: Local build script that compiles the `.mez` and copies it.
- `HubSpotConnector.query.pq`: Test query used with PQTest.

Build and test
--------------
1) Build the connector:
   - Run `.\build-desktop.ps1` from `HubSpot/code`.
2) Test the connector (requires PQTest.exe):
   - Use the command in `README.md` and supply the local PQTest path.
3) If credentials are missing in PQTest:
   - Use the `set-credential` JSON format shown in `README.md` (it expects
     `AuthenticationProperties.Key`).
4) If a custom object returns 0 rows but Postman shows data:
   - Check that pagination includes the first page even when `paging.next` is null.
   - The connector's `GetAllPages` now includes the initial page by default.

Custom objects and associations
-------------------------------
Partner Network Application:
- Object type: `0-420`
- Properties: static list sourced from `Partner Network Application-2026-01-07.zip` (`listing.csv`)
- Associations: `companies`, `contacts`, `2-221830980` (Partner Products and Systems),
  `0-3` (Opportunities), `tickets`

Partner Contracts:
- Object type: `2-222440285`
- Properties: static list sourced from `docs/postman/List Schemas (confirm object detail)`
- Associations (by objectTypeId): `0-116`, `0-18`, `0-2`, `0-27`, `0-3`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`

Partner Product Communication Details:
- Object type: `2-221836290`
- Properties: static list sourced from `docs/postman/List Schemas (confirm object detail)`
- Associations (by objectTypeId): `0-1`, `0-116`, `0-18`, `0-2`, `0-27`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`, `0-970`, `2-221830980`

Partner Products and Systems:
- Object type: `2-221830980`
- Properties: static list sourced from `docs/postman/List Schemas (confirm object detail)`
- Associations (by objectTypeId): `0-1`, `0-116`, `0-162`, `0-18`, `0-2`, `0-27`, `0-3`, `0-420`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`, `0-970`, `2-221836290`

Selecting objects in Power BI
-----------------------------
The connector exposes each object as a separate table in the Navigator. Users can
manually select which tables to load; non-selected tables are not queried.

Standard objects added (dynamic properties)
-------------------------------------------
These use `/crm/v3/properties/{objectType}` at runtime to build the property list.

- Carts
- Leads
- Line Items
- Orders
- Quotes
- Subscriptions
- Tickets
- Calls
- Emails
- Meetings
- Notes
- Postal Mail
- Tasks
- Courses
- Partner Product Releases
- Opportunities (alias of Deals)

Pending objects
---------------
These require confirmed object type names/IDs before adding:
- LinkedIn Messages
- SMS
- WhatsApp Messages

Reference URLs (HubSpot UI)
---------------------------
- Partner Network Applications: https://app-na2.hubspot.com/object-type-settings/44204548/object/0-420
- Partner Products and Systems: https://app-na2.hubspot.com/object-type-settings/44204548/object/2-221830980
- Opportunities: https://app-na2.hubspot.com/object-type-settings/44204548/object/0-3
Postman collection
------------------
`docs/postman/HubSpot-Partner-Network-Application.postman_collection.json` includes
requests for schemas, custom objects, and standard objects. It uses the placeholder
workspace name `Kno2 HubSpot Connector` and requires `accessToken` to be set.

Editing guidance
----------------
- When adding a new object, update:
  - object suffix URL constants
  - properties/associations config
  - navigation table entries
  - README object list

Branding sources (Power BI/reporting)
------------------------------------
- `docs/kno2-brand-guidelines-documents/Kno2 Connected Brand Guidelines_2025.docx`
- `docs/kno2-brand-guidelines-documents/Kno2 Brand Guidelines_June23.pptx`
- `docs/powerbi/Branding_Guide.json` (single source of truth for report themes)
- `docs/powerbi/Corporate_Theme.json` (mandatory theme for reports)

Branding and editorial requirements
-----------------------------------
- Use "Kno2" as one word; do not abbreviate (no "K2").
- First reference to the organization name should include the registered trademark symbol (R).
- Use "Kno2 Connected" in public-facing references to integrated products; "connected by Kno2" is acceptable for grammar.
- Place the Kno2 Connected attribution prominently in UI and public materials; private-label partners must show it at login.
- Preferred logo: full-color Kno2 icon with blue dots; alternate is full-color icon with white dots if needed.
- Maintain correct aspect ratio, clear space, and minimum reproduction sizes (print minimum 1 inch; on-screen minimum 120 px, confirm exact dimension in the brand deck).
- Use the brand palette from `docs/powerbi/Branding_Guide.json`; yellow is reserved for calls to action.
- Approved messaging snippets for partnership, integrated technology, and QHIN live in `docs/powerbi/Branding_Guide.json`.
- If referencing third-party networks or services, follow their official branding:
  - DocuSign: brand.docusign.com
  - DirectTrust: directtrust.org/resources
  - Carequality: "Carequality" is a framework; do not italicize the "e" in plain text.
  - TEFCA: use full name "Trusted Exchange Framework and Common Agreement (TEFCA)" in plain text.

Report design framework (DAR)
-----------------------------
- Executive tier (What): KPI cards, status indicators, trend lines; low interaction.
- Managerial tier (Why): slicers, drill-throughs, Top N lists; moderate interaction.
- Individual contributor tier (How): detailed tables, row-level data, exportable lists; high interaction.

Persona definitions
-------------------
- Executive: minimal interaction, high-level aggregates; focus on "the what".
- Manager: high interaction with slicers and drill-throughs; focus on "the why".
- Individual contributor: tactical interaction with exportable detail; focus on "the how".

Operational guidelines for reports
----------------------------------
Development workflow
1) Discovery: confirm the primary action with "If this number is red, what is the first button the user needs to click?"
2) Wireframe: map the three-tier experience (Dashboard > Analysis > Reporting).
3) Application: apply `CLAUSES.md` standards for branding and accessibility.
4) Validation: cross-check with `SKILLS.md` performance engineering; target < 3 seconds load time.

Discovery phase
- Ask: "What decision will you change based on this number?"
- If a metric changes, define the next step and build a drill-through to that action.

Layout and navigation
- Keep global filters in a consistent location (prefer a collapsible left pane).
- Use clear page titles, breadcrumbs, and navigation buttons.
- Add summary tooltips with a mini-trend line for key points.
- Always include a back button or clear hierarchy indicator.

Performance and maintenance
- Limit visuals to 8 or fewer per page.
- Executive tier requires certified datasets validated against `Master_Metric_Dictionary.md`.

Reference library
-----------------
- See `references.md` for external Power BI design benchmarks and required review steps.
