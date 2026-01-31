# Kno2 Partner Network Report - Quick Setup Guide

## Prerequisites

1. **Power BI Desktop** (latest version)
2. **Kno2HubSpotConnector.mez** installed in:
   - `%USERPROFILE%\Documents\Power BI Desktop\Custom Connectors\`
3. **HubSpot Private App Access Token** with scopes:
   - `crm.objects.custom.read`
   - `crm.objects.owners.read`
   - `crm.schemas.read`

---

## Step 1: Create New Power BI Report

1. Open Power BI Desktop
2. Go to **File > Options and settings > Options**
3. Under **Security**, set Data Extensions to **(Not Recommended) Allow any extension...**
4. Restart Power BI Desktop

---

## Step 2: Apply Corporate Theme

1. Go to **View > Themes > Browse for themes**
2. Select: `docs/powerbi/Corporate_Theme.json`
3. Click **Open** to apply

---

## Step 3: Connect to HubSpot Data

1. **Home > Get Data > More...**
2. Search for **HubSpot** or find under **Online Services**
3. Click **Connect**
4. Enter your **Private App Access Token**
5. In the Navigator, select these tables:
   - [x] HubSpot Custom Partner Network Application
   - [x] HubSpot Custom Partner Products and Systems
   - [x] HubSpot Custom Partner Product Communication Details
   - [x] HubSpot CRM Owners
6. Click **Transform Data** (not Load)

---

## Step 4: Apply Power Query Transformations

Open `docs/powerbi/Partner-Network-PowerQuery.pq` and copy each query block:

### 4.1 Partner Network Applications
1. In Power Query Editor, right-click **HubSpot Custom Partner Network Application**
2. Select **Advanced Editor**
3. Replace with the `Partner Network Applications (transformed)` query
4. Rename query to: `Partner Network Applications`

### 4.2 Partner Products and Systems
1. Right-click **HubSpot Custom Partner Products and Systems**
2. Select **Advanced Editor**
3. Replace with the `Partner Products and Systems (transformed)` query
4. Rename query to: `Partner Products and Systems`

### 4.3 Partner Product Communication Details
1. Right-click **HubSpot Custom Partner Product Communication Details**
2. Select **Advanced Editor**
3. Replace with the `Partner Product Communication Details (transformed)` query
4. Rename query to: `Partner Product Communication Details`

### 4.4 Owners
1. Right-click **HubSpot CRM Owners**
2. Select **Advanced Editor**
3. Replace with the `Owners` query
4. Rename query to: `Owners`

### 4.5 Bridge Tables (New Queries)
1. **Home > New Source > Blank Query**
2. Open **Advanced Editor**
3. Paste `Application-Product Bridge Table` query
4. Name it: `ApplicationProductBridge`
5. Repeat for `Product-Communication Bridge Table` → name: `ProductCommunicationBridge`

### 4.6 Date Table
1. **Home > New Source > Blank Query**
2. Open **Advanced Editor**
3. Paste `Date Dimension` query
4. Name it: `Date`
5. **Mark as Date Table**: Right-click Date table > Mark as date table > Select `Date` column

---

## Step 5: Load Data & Create Relationships

1. Click **Close & Apply**
2. Go to **Model view** (left sidebar)

### Create Relationships:

| From Table | From Column | To Table | To Column | Cardinality |
|------------|-------------|----------|-----------|-------------|
| Partner Network Applications | hubspot_owner_id | Owners | id | Many-to-One |
| Partner Products and Systems | hubspot_owner_id | Owners | id | Many-to-One |
| Partner Product Communication Details | hubspot_owner_id | Owners | id | Many-to-One |
| Partner Network Applications | CreateDateKey | Date | Date | Many-to-One |
| Partner Products and Systems | CreateDateKey | Date | Date | Many-to-One |
| Partner Product Communication Details | CreateDateKey | Date | Date | Many-to-One |
| ApplicationProductBridge | ApplicationId | Partner Network Applications | hs_object_id | Many-to-One |
| ApplicationProductBridge | ProductId | Partner Products and Systems | hs_object_id | Many-to-One |
| ProductCommunicationBridge | ProductId | Partner Products and Systems | hs_object_id | Many-to-One |
| ProductCommunicationBridge | CommunicationId | Partner Product Communication Details | hs_object_id | Many-to-One |

---

## Step 6: Create DAX Measures

1. Go to **Data view**
2. Select **Partner Network Applications** table
3. **Table tools > New measure**
4. Copy measures from `Partner-Network-Report-Template.md` DAX Measures section

### Essential Measures to Create First:

```dax
// In Partner Network Applications table
Total Applications = COUNTROWS('Partner Network Applications')

Applications This Month =
CALCULATE(
    [Total Applications],
    'Date'[IsCurrentMonth] = TRUE
)

Avg Days Since Status Update =
AVERAGE('Partner Network Applications'[days_since_status_last_updated])

Approval Rate =
VAR Approved = CALCULATE([Total Applications], 'Partner Network Applications'[network_application_status] = "approved")
VAR Total = [Total Applications]
RETURN DIVIDE(Approved, Total, 0)
```

```dax
// In Partner Products and Systems table
Total Products = COUNTROWS('Partner Products and Systems')

API Integration Rate =
VAR WithAPI = CALCULATE([Total Products], 'Partner Products and Systems'[api_access] = "Yes")
RETURN DIVIDE(WithAPI, [Total Products], 0)
```

```dax
// In Partner Product Communication Details table
Total Communications = COUNTROWS('Partner Product Communication Details')
```

---

## Step 7: Build Report Pages

### Page 1: Executive Dashboard
1. **Insert > Text box**: "Kno2(R) Partner Network Operations"
2. Add 3 **Card** visuals across top:
   - Total Applications
   - Approval Rate (format as %)
   - Avg Days Since Status Update
3. Add **Donut chart**: network_application_status by Total Applications
4. Add **Area chart**: YearMonth (X) by Total Applications (Y)
5. Add **Stacked bar**: Integration metrics

### Page 2: Applications Analysis
1. Duplicate Page 1, rename to "Applications Analysis"
2. Replace visuals with:
   - Funnel: hs_pipeline_stage
   - Bar: Owner workload
   - Treemap: failure_reason
   - Table: Application details
3. Add slicers: Status, Owner, Path, Date Range

### Page 3: Products & Communications
1. New page, rename to "Products & Communications"
2. Add product metrics cards
3. Add integration matrix
4. Add communication donut by modality
5. Add slicers: Partner Type, Status with Kno2

### Page 4: Detail Tables
1. New page, rename to "Detail"
2. Add 3 tables with key columns from each fact table
3. Enable: Search, Export, Sorting
4. Configure drill-through from Pages 2-3

---

## Step 8: Configure Navigation

1. On Pages 2-4, add **Back button**:
   - Insert > Buttons > Back
   - Format > Action > Type: Back
2. Add page navigator if desired:
   - Insert > Buttons > Navigator > Page navigator

---

## Step 9: Validate & Export

### Validation Checklist:
- [ ] All 4 pages load without errors
- [ ] Slicers filter correctly across visuals
- [ ] Drill-through works from tables to detail
- [ ] Page load time < 3 seconds
- [ ] Theme colors applied correctly
- [ ] All cards show data (not blank)

### Export as Template:
1. **File > Export > Power BI template (.pbit)**
2. Add description: "Kno2 Partner Network Operations - DAR Model Report"
3. Save as: `Kno2-Partner-Network-Operations.pbit`

---

## Troubleshooting

### "No data" in visuals
- Verify HubSpot token has correct scopes
- Check that tables loaded rows in Data view
- Verify relationships are active (solid line in Model view)

### Bridge tables empty
- Confirm `associations` column exists in source tables
- Check that associations are populated in HubSpot

### Theme not applying
- Re-apply theme after creating visuals
- Check that Din font is installed (fallback: Segoe UI)

### Slow performance
- Reduce visuals per page (max 8)
- Consider aggregating data in Power Query
- Check for circular relationships in Model view

---

## File Locations

| File | Purpose |
|------|---------|
| `docs/powerbi/Corporate_Theme.json` | Power BI theme |
| `docs/powerbi/Branding_Guide.json` | Color/font reference |
| `docs/powerbi/Partner-Network-Report-Template.md` | Full specification |
| `docs/powerbi/Partner-Network-PowerQuery.pq` | M query code |
| `docs/powerbi/Partner-Network-Report-Setup.md` | This guide |
