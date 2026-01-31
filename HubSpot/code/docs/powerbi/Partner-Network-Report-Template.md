# Kno2 Partner Network Report Template

## Report Overview
**Title:** Kno2(R) Partner Network Operations
**Version:** 1.0.0
**Last Updated:** 2026-01-08
**Theme:** Corporate_Theme.json

This report follows the DAR (Dashboard-Analysis-Reporting) model with three tiers:
- **Executive** (Page 1): High-level KPIs and status indicators
- **Manager** (Pages 2-3): Drill-throughs, slicers, and trend analysis
- **Individual Contributor** (Page 4): Detailed exportable tables

---

## Data Model

### Tables (from Kno2 HubSpot Connector)

| Table Name | Source | Role |
|------------|--------|------|
| Partner Network Applications | `HubSpot Custom Partner Network Application` | Fact table (primary) |
| Partner Products and Systems | `HubSpot Custom Partner Products and Systems` | Fact/Dimension table |
| Partner Product Communication Details | `HubSpot Custom Partner Product Communication Details` | Fact table |
| Owners | `HubSpot CRM Owners` | Dimension table |
| Date | Generated | Date dimension |

### Relationships

```
Partner Network Applications (0-420)
    │
    ├── [hs_object_id] ──M:1── Partner Products and Systems [associations.0-420.results{0}.id]
    │
    └── [hubspot_owner_id] ──M:1── Owners [id]

Partner Products and Systems (2-221830980)
    │
    ├── [hs_object_id] ──1:M── Partner Product Communication Details [associations.2-221830980.results{0}.id]
    │
    └── [hubspot_owner_id] ──M:1── Owners [id]

Partner Product Communication Details (2-221836290)
    │
    └── [hubspot_owner_id] ──M:1── Owners [id]

Date (Generated)
    │
    ├── [Date] ──1:M── Partner Network Applications [hs_createdate]
    ├── [Date] ──1:M── Partner Products and Systems [hs_createdate]
    └── [Date] ──1:M── Partner Product Communication Details [hs_createdate]
```

### Bridge Table for Many-to-Many (if needed)
If associations return multiple IDs, create a bridge table:
```
ApplicationProductBridge
- application_id (from Partner Network Applications.hs_object_id)
- product_id (from associations.2-221830980.results[*].id)
```

---

## Date Table (DAX)

```dax
Date =
VAR MinDate = MIN(
    MIN('Partner Network Applications'[hs_createdate]),
    MIN('Partner Products and Systems'[hs_createdate])
)
VAR MaxDate = TODAY()
RETURN
ADDCOLUMNS(
    CALENDAR(DATE(YEAR(MinDate), 1, 1), MaxDate),
    "Year", YEAR([Date]),
    "Quarter", "Q" & QUARTER([Date]),
    "Month", FORMAT([Date], "MMM"),
    "MonthNum", MONTH([Date]),
    "YearMonth", FORMAT([Date], "YYYY-MM"),
    "WeekNum", WEEKNUM([Date]),
    "DayOfWeek", FORMAT([Date], "ddd"),
    "IsCurrentMonth", IF(MONTH([Date]) = MONTH(TODAY()) && YEAR([Date]) = YEAR(TODAY()), TRUE, FALSE)
)
```

---

## DAX Measures

### Application Metrics

```dax
// Count Measures
Total Applications = COUNTROWS('Partner Network Applications')

Applications This Month =
CALCULATE(
    [Total Applications],
    'Date'[IsCurrentMonth] = TRUE
)

Applications by Status =
CALCULATE(
    [Total Applications],
    ALLEXCEPT('Partner Network Applications', 'Partner Network Applications'[network_application_status])
)

// Pipeline Stage Counts
Applications In Review =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[hs_pipeline_stage] = "in_review"
)

Applications Approved =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[network_application_status] = "approved"
)

Applications Pending =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[network_application_status] = "pending"
)

Applications Failed =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[network_application_status] = "failed"
)

// Age Metrics
Avg Days Since Created =
AVERAGE('Partner Network Applications'[days_since_created])

Avg Days Since Status Update =
AVERAGE('Partner Network Applications'[days_since_status_last_updated])

Applications Aging >30 Days =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[days_since_status_last_updated] > 30
)

// Path Distribution
Path A Applications =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[path_sync_airtablena] = "Path A"
)

Path B Applications =
CALCULATE(
    [Total Applications],
    'Partner Network Applications'[path_sync_airtablena] = "Path B"
)

// Approval Rate
Approval Rate =
DIVIDE(
    [Applications Approved],
    [Total Applications] - [Applications Pending],
    0
)
```

### Product Metrics

```dax
Total Products = COUNTROWS('Partner Products and Systems')

Products Active =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[status_with_kno2] = "active"
)

Products by Type =
CALCULATE(
    [Total Products],
    ALLEXCEPT('Partner Products and Systems', 'Partner Products and Systems'[product_system_type])
)

// Integration Metrics
Products with API Access =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[api_access] = "Yes"
)

Products with EHR Integration =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[ehr_api_integration] = "Yes"
)

Products with Portal Access =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[end_user_portal_access] = "Yes"
)

API Integration Rate =
DIVIDE([Products with API Access], [Total Products], 0)

// Purpose of Use
Products Find Enabled =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[purpose_of_use_find] <> BLANK()
)

Products Respond Enabled =
CALCULATE(
    [Total Products],
    'Partner Products and Systems'[purpose_of_use_respond] <> BLANK()
)
```

### Communication Metrics

```dax
Total Communications = COUNTROWS('Partner Product Communication Details')

Communications by Modality =
CALCULATE(
    [Total Communications],
    ALLEXCEPT('Partner Product Communication Details', 'Partner Product Communication Details'[modality])
)

Communications by Vendor =
CALCULATE(
    [Total Communications],
    ALLEXCEPT('Partner Product Communication Details', 'Partner Product Communication Details'[vendor])
)

Avg Communications per Product =
DIVIDE(
    [Total Communications],
    [Total Products],
    0
)
```

### Owner/Team Metrics

```dax
Applications per Owner =
DIVIDE(
    [Total Applications],
    DISTINCTCOUNT('Partner Network Applications'[hubspot_owner_id]),
    0
)

Owner Workload Index =
VAR OwnerApps =
    CALCULATE(
        [Total Applications],
        ALLEXCEPT('Partner Network Applications', 'Partner Network Applications'[hubspot_owner_id])
    )
VAR AvgApps = [Applications per Owner]
RETURN
DIVIDE(OwnerApps, AvgApps, 1)
```

### Trend Measures

```dax
Applications MoM Growth =
VAR CurrentMonth = [Applications This Month]
VAR PriorMonth =
    CALCULATE(
        [Total Applications],
        DATEADD('Date'[Date], -1, MONTH)
    )
RETURN
DIVIDE(CurrentMonth - PriorMonth, PriorMonth, 0)

Applications YTD =
CALCULATE(
    [Total Applications],
    DATESYTD('Date'[Date])
)

Applications Rolling 90 Days =
CALCULATE(
    [Total Applications],
    DATESINPERIOD('Date'[Date], MAX('Date'[Date]), -90, DAY)
)
```

### Conditional Formatting Measures

```dax
Aging Status Color =
SWITCH(
    TRUE(),
    [Avg Days Since Status Update] > 30, "#E77A3C",  // Orange - Warning
    [Avg Days Since Status Update] > 14, "#FBC908",  // Yellow - Caution
    "#19A7DE"  // Sky Blue - Good
)

Approval Rate Status =
SWITCH(
    TRUE(),
    [Approval Rate] >= 0.8, "#19A7DE",   // Good
    [Approval Rate] >= 0.6, "#FBC908",   // Caution
    "#E77A3C"  // Warning
)
```

---

## Page Specifications

### Page 1: Executive Dashboard

**Purpose:** Quick status view for leadership - "What is happening?"
**Interaction Level:** Low (view only, minimal clicking)
**Visual Count:** 6 (under 8-limit)

| Visual | Type | Measures/Fields | Position |
|--------|------|-----------------|----------|
| Total Applications | Card | [Total Applications] | Top-left |
| Approval Rate | KPI | [Approval Rate], Target: 80% | Top-center |
| Avg Days Aging | Card with conditional | [Avg Days Since Status Update], [Aging Status Color] | Top-right |
| Application Status | Donut Chart | [network_application_status], [Total Applications] | Middle-left |
| Monthly Trend | Area Chart | Date[YearMonth], [Total Applications] | Middle-right |
| Products by Integration | Stacked Bar | [Products with API Access], [Products with EHR Integration] | Bottom |

**Filters:** Date range slicer (collapsed left pane)

---

### Page 2: Manager - Applications Analysis

**Purpose:** Drill into application pipeline and team workload - "Why are we seeing these numbers?"
**Interaction Level:** Moderate (slicers, drill-through enabled)
**Visual Count:** 7

| Visual | Type | Measures/Fields | Position |
|--------|------|-----------------|----------|
| Pipeline Funnel | Funnel | [hs_pipeline_stage], [Total Applications] | Top-left |
| Owner Workload | Bar Chart | Owners[firstName], [Owner Workload Index] | Top-right |
| Path Distribution | Pie Chart | [path_sync_airtablena], [Total Applications] | Middle-left |
| Aging Heatmap | Matrix | [network_application_status], [days_since_status_last_updated bins] | Middle-center |
| Failure Reasons | Treemap | [failure_reason], [Applications Failed] | Middle-right |
| Applications Table | Table | Key fields with drill-through | Bottom |
| Status Trend | Line Chart | Date[YearMonth], [network_application_status], Count | Bottom-right |

**Slicers:**
- Status (multi-select)
- Owner (multi-select)
- Path (A/B)
- Date Range

**Drill-through:** Click application row → Page 4 Detail

---

### Page 3: Manager - Products & Communications

**Purpose:** Analyze product integration status and communication patterns
**Interaction Level:** Moderate
**Visual Count:** 7

| Visual | Type | Measures/Fields | Position |
|--------|------|-----------------|----------|
| Product Status Overview | Card Grid | [Total Products], [Products Active], [API Integration Rate] | Top |
| Products by Type | Column Chart | [product_system_type], [Total Products] | Middle-left |
| Integration Matrix | Matrix | [api_access], [ehr_api_integration], [end_user_portal_access] | Middle-center |
| Care Settings | Bar Chart | [care_settings], [Total Products] | Middle-right |
| Communications by Modality | Donut | [modality], [Total Communications] | Bottom-left |
| Communications by Vendor | Bar | [vendor], [Total Communications] | Bottom-center |
| Product-to-Communication Ratio | KPI | [Avg Communications per Product] | Bottom-right |

**Slicers:**
- Partner Type
- Product System Type
- Status with Kno2
- Modality

---

### Page 4: IC Detail - Exportable Tables

**Purpose:** Provide row-level data for action - "How do I fix this?"
**Interaction Level:** High (export, search, sort)
**Visual Count:** 3 (table-focused)

| Visual | Type | Purpose |
|--------|------|---------|
| Applications Detail Table | Table | Full application record with all key fields |
| Products Detail Table | Table | Full product record with integration flags |
| Communications Detail Table | Table | Full communication record with vendor/modality |

**Table Columns - Applications:**
- hs_object_id, hs_name, company_name_sync_pouairtable, network_application_status
- hs_pipeline_stage, path_sync_airtablena, days_since_created, days_since_status_last_updated
- hubspot_owner_id (linked to Owner name), failure_reason, hs_createdate

**Table Columns - Products:**
- hs_object_id, product_name, partner_brand, product_system_type, status_with_kno2
- api_access, ehr_api_integration, end_user_portal_access, care_settings
- purpose_of_use_find, purpose_of_use_respond, hs_createdate

**Table Columns - Communications:**
- hs_object_id, modality, vendor, hs_createdate, hubspot_owner_id

**Features:**
- Search box enabled
- Export to Excel button
- Column sorting
- Row-level conditional formatting for aging

---

## Visual Formatting (from Corporate_Theme.json)

### Colors
| Use | Color | Hex |
|-----|-------|-----|
| Primary data series 1 | Deep Blue | #01248E |
| Primary data series 2 | Blue | #005697 |
| Primary data series 3 | Azure | #0B7DC2 |
| Primary data series 4 | Sky | #19A7DE |
| Accent/CTA | Yellow | #FBC908 |
| Warning | Orange | #E77A3C |
| Table accent | Sky | #19A7DE |
| Background | White | #FFFFFF |
| Text | Black | #060707 |

### Typography
| Element | Font | Size |
|---------|------|------|
| Title | Din | 12pt |
| Callout/KPI | Din | 14pt |
| Labels | Segoe UI | 10pt |

### Card Formatting
- Background: Transparent
- Border: Off
- Title: Show, Din font, #060707

---

## Report Deployment Checklist

- [ ] Import Corporate_Theme.json
- [ ] Connect to Kno2 HubSpot Connector
- [ ] Load required tables (4 + Date dimension)
- [ ] Create relationships as specified
- [ ] Create all DAX measures
- [ ] Build Page 1 (Executive)
- [ ] Build Page 2 (Manager - Applications)
- [ ] Build Page 3 (Manager - Products)
- [ ] Build Page 4 (IC Detail)
- [ ] Configure drill-through from Page 2/3 → Page 4
- [ ] Add navigation buttons (back buttons on Pages 2-4)
- [ ] Test all slicers and interactions
- [ ] Validate < 3 second load time
- [ ] Export as .pbit template
