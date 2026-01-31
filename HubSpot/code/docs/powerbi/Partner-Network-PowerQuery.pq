// ============================================================
// Kno2 Partner Network Report - Power Query Transformations
// ============================================================
// Import these queries into Power BI after connecting to
// the Kno2 HubSpot Connector.
// ============================================================

// ------------------------------------------------------------
// QUERY: Partner Network Applications (transformed)
// Source: HubSpot Custom Partner Network Application
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    PartnerNetworkApplications = Source{[Key="PartnerNetworkApplications"]}[Data],

    // Convert date columns
    #"Changed Type Dates" = Table.TransformColumnTypes(PartnerNetworkApplications, {
        {"hs_createdate", type datetime},
        {"hs_lastmodifieddate", type datetime},
        {"hubspot_owner_assigneddate", type datetime}
    }),

    // Convert numeric columns
    #"Changed Type Numbers" = Table.TransformColumnTypes(#"Changed Type Dates", {
        {"days_since_created", type number},
        {"days_since_status_last_updated", type number}
    }),

    // Add date key for relationships
    #"Added Date Key" = Table.AddColumn(#"Changed Type Numbers", "CreateDateKey",
        each Date.From([hs_createdate]), type date),

    // Clean status values
    #"Cleaned Status" = Table.TransformColumns(#"Added Date Key", {
        {"network_application_status", each Text.Trim(Text.Clean(_)), type text}
    }),

    // Extract company name for display
    #"Added Company Display" = Table.AddColumn(#"Cleaned Status", "CompanyName",
        each if [company_name_sync_pouairtable] <> null then [company_name_sync_pouairtable]
             else if [company_name__dba_sync_airtablena] <> null then [company_name__dba_sync_airtablena]
             else [legal_name_syn_airtablena], type text),

    // Add aging bucket
    #"Added Aging Bucket" = Table.AddColumn(#"Added Company Display", "AgingBucket",
        each if [days_since_status_last_updated] = null then "Unknown"
             else if [days_since_status_last_updated] <= 7 then "0-7 days"
             else if [days_since_status_last_updated] <= 14 then "8-14 days"
             else if [days_since_status_last_updated] <= 30 then "15-30 days"
             else "30+ days", type text),

    // Add path display name
    #"Added Path Display" = Table.AddColumn(#"Added Aging Bucket", "ApplicationPath",
        each if Text.Contains([path_sync_airtablena] ?? "", "A") then "Path A"
             else if Text.Contains([path_sync_airtablena] ?? "", "B") then "Path B"
             else "Not Specified", type text),

    // Convert owner id to text for relationship matching
    #"Convert Owner ID" = Table.TransformColumns(#"Added Path Display", {
        {"hubspot_owner_id", each Text.From(_ ?? ""), type text}
    }),

    // Select and rename key columns for clarity
    #"Selected Columns" = Table.SelectColumns(#"Convert Owner ID", {
        "id", "hs_object_id", "hs_name", "CompanyName", "network_application_status",
        "hs_pipeline", "hs_pipeline_stage", "ApplicationPath", "failure_reason",
        "days_since_created", "days_since_status_last_updated", "AgingBucket",
        "hubspot_owner_id", "hubspot_team_id", "hs_createdate", "hs_lastmodifieddate",
        "CreateDateKey", "kno2_partner_id", "kno2_partner_id_number",
        "business_development_representative", "submitter_email_sync_naairtable",
        "solution_name_sync_airtablena", "solution_description_sync_airtablena",
        "associations"
    })
in
    #"Selected Columns"

// ------------------------------------------------------------
// QUERY: Partner Products and Systems (transformed)
// Source: HubSpot Custom Partner Products and Systems
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    PartnerProducts = Source{[Key="PartnerProductsAndSystems"]}[Data],

    // Convert date columns
    #"Changed Type Dates" = Table.TransformColumnTypes(PartnerProducts, {
        {"hs_createdate", type datetime},
        {"hs_lastmodifieddate", type datetime}
    }),

    // Add date key for relationships
    #"Added Date Key" = Table.AddColumn(#"Changed Type Dates", "CreateDateKey",
        each Date.From([hs_createdate]), type date),

    // Standardize Yes/No fields to boolean display
    #"Cleaned API Access" = Table.TransformColumns(#"Added Date Key", {
        {"api_access", each if Text.Lower(_ ?? "") = "yes" then "Yes" else if Text.Lower(_ ?? "") = "no" then "No" else "Unknown", type text},
        {"ehr_api_integration", each if Text.Lower(_ ?? "") = "yes" then "Yes" else if Text.Lower(_ ?? "") = "no" then "No" else "Unknown", type text},
        {"end_user_portal_access", each if Text.Lower(_ ?? "") = "yes" then "Yes" else if Text.Lower(_ ?? "") = "no" then "No" else "Unknown", type text},
        {"ehr_certification", each if Text.Lower(_ ?? "") = "yes" then "Yes" else if Text.Lower(_ ?? "") = "no" then "No" else "Unknown", type text}
    }),

    // Add integration score (count of Yes values)
    #"Added Integration Score" = Table.AddColumn(#"Cleaned API Access", "IntegrationScore",
        each (if [api_access] = "Yes" then 1 else 0) +
             (if [ehr_api_integration] = "Yes" then 1 else 0) +
             (if [end_user_portal_access] = "Yes" then 1 else 0) +
             (if [ehr_certification] = "Yes" then 1 else 0), Int64.Type),

    // Add integration tier
    #"Added Integration Tier" = Table.AddColumn(#"Added Integration Score", "IntegrationTier",
        each if [IntegrationScore] >= 3 then "Fully Integrated"
             else if [IntegrationScore] >= 2 then "Partially Integrated"
             else if [IntegrationScore] >= 1 then "Minimal Integration"
             else "Not Integrated", type text),

    // Convert owner id to text for relationship matching
    #"Convert Owner ID" = Table.TransformColumns(#"Added Integration Tier", {
        {"hubspot_owner_id", each Text.From(_ ?? ""), type text}
    }),

    // Select key columns
    #"Selected Columns" = Table.SelectColumns(#"Convert Owner ID", {
        "id", "hs_object_id", "product_name", "partner_brand", "product_description",
        "product_system_type", "partner_type", "primary_purpose", "status_with_kno2",
        "care_settings", "api_access", "ehr_api_integration", "end_user_portal_access",
        "ehr_certification", "IntegrationScore", "IntegrationTier",
        "purpose_of_use_find", "purpose_of_use_respond",
        "hs_pipeline", "hs_pipeline_stage", "jira_id", "oid",
        "hubspot_owner_id", "hubspot_team_id", "hs_createdate", "hs_lastmodifieddate",
        "CreateDateKey", "associations"
    })
in
    #"Selected Columns"

// ------------------------------------------------------------
// QUERY: Partner Product Communication Details (transformed)
// Source: HubSpot Custom Partner Product Communication Details
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    Communications = Source{[Key="PartnerProductCommunicationDetails"]}[Data],

    // Remove rows with errors in id/hs_object_id (blank/invalid records from HubSpot)
    #"Removed Errors" = Table.RemoveRowsWithErrors(Communications, {"id", "hs_object_id"}),

    // Filter out rows where id is null or blank
    #"Filtered Blanks" = Table.SelectRows(#"Removed Errors",
        each [id] <> null and [hs_object_id] <> null),

    // Convert date columns
    #"Changed Type Dates" = Table.TransformColumnTypes(#"Filtered Blanks", {
        {"hs_createdate", type datetime},
        {"hs_lastmodifieddate", type datetime}
    }),

    // Add date key for relationships
    #"Added Date Key" = Table.AddColumn(#"Changed Type Dates", "CreateDateKey",
        each Date.From([hs_createdate]), type date),

    // Standardize modality values
    #"Cleaned Modality" = Table.TransformColumns(#"Added Date Key", {
        {"modality", each Text.Proper(Text.Trim(_ ?? "Unknown")), type text}
    }),

    // Standardize vendor values
    #"Cleaned Vendor" = Table.TransformColumns(#"Cleaned Modality", {
        {"vendor", each Text.Proper(Text.Trim(_ ?? "Unknown")), type text}
    }),

    // Convert owner id to text for relationship matching
    #"Convert Owner ID" = Table.TransformColumns(#"Cleaned Vendor", {
        {"hubspot_owner_id", each Text.From(_ ?? ""), type text}
    }),

    // Select key columns
    #"Selected Columns" = Table.SelectColumns(#"Convert Owner ID", {
        "id", "hs_object_id", "modality", "vendor",
        "hubspot_owner_id", "hubspot_team_id", "hs_createdate", "hs_lastmodifieddate",
        "CreateDateKey", "associations"
    })
in
    #"Selected Columns"

// ------------------------------------------------------------
// QUERY: Owners (for dimension)
// Source: HubSpot CRM Owners
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    Owners = Source{[Key="Owners"]}[Data],

    // Remove rows with errors in id column (invalid/system owners from HubSpot)
    #"Removed Errors" = Table.RemoveRowsWithErrors(Owners, {"id"}),

    // Convert id to text for relationship matching
    #"Changed ID Type" = Table.TransformColumnTypes(#"Removed Errors", {{"id", type text}}),

    // Add full name column
    #"Added Full Name" = Table.AddColumn(#"Changed ID Type", "FullName",
        each Text.Combine({[firstName] ?? "", [lastName] ?? ""}, " "), type text),

    // Convert dates
    #"Changed Type Dates" = Table.TransformColumnTypes(#"Added Full Name", {
        {"createdAt", type datetime},
        {"updatedAt", type datetime}
    }),

    // Select key columns
    #"Selected Columns" = Table.SelectColumns(#"Changed Type Dates", {
        "id", "email", "firstName", "lastName", "FullName", "type",
        "userId", "createdAt", "updatedAt", "archived"
    })
in
    #"Selected Columns"

// ------------------------------------------------------------
// QUERY: Application-Product Bridge Table
// Purpose: Flatten many-to-many between Applications and Products
// Source: Partner Network Applications.associations
// Note: HubSpot uses portal-prefixed names like "p44204548_partner_products"
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    Applications = Source{[Key="PartnerNetworkApplications"]}[Data],

    // Keep only id and associations
    #"Select Columns" = Table.SelectColumns(Applications, {"hs_object_id", "associations"}),

    // Filter to rows with associations
    #"Filter Has Associations" = Table.SelectRows(#"Select Columns",
        each [associations] <> null),

    // Expand to get Product associations using portal-prefixed name
    #"Get Product Associations" = Table.AddColumn(#"Filter Has Associations", "ProductIds",
        each try Record.Field([associations], "p44204548_partner_products")[results] otherwise null),

    // Filter nulls
    #"Filter Product Associations" = Table.SelectRows(#"Get Product Associations",
        each [ProductIds] <> null),

    // Expand list of products
    #"Expanded Products" = Table.ExpandListColumn(#"Filter Product Associations", "ProductIds"),

    // Expand product record to get id
    #"Expanded Product Record" = Table.ExpandRecordColumn(#"Expanded Products", "ProductIds", {"id"}, {"ProductId"}),

    // Rename columns
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Product Record", {
        {"hs_object_id", "ApplicationId"}
    }),

    // Select final columns
    #"Final Columns" = Table.SelectColumns(#"Renamed Columns", {"ApplicationId", "ProductId"})
in
    #"Final Columns"

// ------------------------------------------------------------
// QUERY: Product-Communication Bridge Table
// Purpose: Flatten many-to-many between Products and Communications
// Source: Partner Products and Systems.associations
// Note: HubSpot uses portal-prefixed names like "p44204548_partner_communication_details"
// ------------------------------------------------------------
let
    Source = HubSpot.Contents(),
    Products = Source{[Key="PartnerProductsAndSystems"]}[Data],

    // Keep only id and associations
    #"Select Columns" = Table.SelectColumns(Products, {"hs_object_id", "associations"}),

    // Filter to rows with associations
    #"Filter Has Associations" = Table.SelectRows(#"Select Columns",
        each [associations] <> null),

    // Expand to get Communication associations using portal-prefixed name
    #"Get Comm Associations" = Table.AddColumn(#"Filter Has Associations", "CommIds",
        each try Record.Field([associations], "p44204548_partner_communication_details")[results] otherwise null),

    // Filter nulls
    #"Filter Comm Associations" = Table.SelectRows(#"Get Comm Associations",
        each [CommIds] <> null),

    // Expand list of communications
    #"Expanded Comms" = Table.ExpandListColumn(#"Filter Comm Associations", "CommIds"),

    // Expand comm record to get id
    #"Expanded Comm Record" = Table.ExpandRecordColumn(#"Expanded Comms", "CommIds", {"id"}, {"CommunicationId"}),

    // Rename columns
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Comm Record", {
        {"hs_object_id", "ProductId"}
    }),

    // Select final columns
    #"Final Columns" = Table.SelectColumns(#"Renamed Columns", {"ProductId", "CommunicationId"})
in
    #"Final Columns"

// ------------------------------------------------------------
// QUERY: Date Dimension
// Purpose: Calendar table for time intelligence
// Note: Implement as DAX CALENDAR() for better performance,
//       but M version provided for reference
// ------------------------------------------------------------
let
    // Get date range from data - handle ISO 8601 text format
    Source = HubSpot.Contents(),
    Apps = Source{[Key="PartnerNetworkApplications"]}[Data],
    Products = Source{[Key="PartnerProductsAndSystems"]}[Data],

    // Convert ISO 8601 text dates to datetime, then get min
    AppDates = Table.TransformColumnTypes(
        Table.SelectColumns(Apps, {"hs_createdate"}),
        {{"hs_createdate", type datetime}}
    ),
    ProdDates = Table.TransformColumnTypes(
        Table.SelectColumns(Products, {"hs_createdate"}),
        {{"hs_createdate", type datetime}}
    ),

    MinAppDate = List.Min(Table.Column(AppDates, "hs_createdate")),
    MinProdDate = List.Min(Table.Column(ProdDates, "hs_createdate")),

    // Handle nulls and get earliest date
    ValidDates = List.RemoveNulls({MinAppDate, MinProdDate}),
    MinDateTime = if List.IsEmpty(ValidDates) then DateTime.LocalNow() else List.Min(ValidDates),
    MinDate = Date.From(MinDateTime),
    MaxDate = Date.From(DateTime.LocalNow()),

    // Generate date list - start from Jan 1 of min year
    StartDate = #date(Date.Year(MinDate), 1, 1),
    DayCount = Duration.Days(MaxDate - StartDate) + 1,
    DateList = List.Dates(StartDate, DayCount, #duration(1, 0, 0, 0)),

    // Convert to table
    #"Convert to Table" = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    #"Changed Type" = Table.TransformColumnTypes(#"Convert to Table", {{"Date", type date}}),

    // Add date attributes
    #"Added Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),
    #"Added Quarter" = Table.AddColumn(#"Added Year", "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    #"Added Month" = Table.AddColumn(#"Added Quarter", "Month", each Date.ToText([Date], "MMM"), type text),
    #"Added MonthNum" = Table.AddColumn(#"Added Month", "MonthNum", each Date.Month([Date]), Int64.Type),
    #"Added YearMonth" = Table.AddColumn(#"Added MonthNum", "YearMonth", each Date.ToText([Date], "yyyy-MM"), type text),
    #"Added WeekNum" = Table.AddColumn(#"Added YearMonth", "WeekNum", each Date.WeekOfYear([Date]), Int64.Type),
    #"Added DayOfWeek" = Table.AddColumn(#"Added WeekNum", "DayOfWeek", each Date.ToText([Date], "ddd"), type text),
    #"Added IsCurrentMonth" = Table.AddColumn(#"Added DayOfWeek", "IsCurrentMonth",
        each Date.Month([Date]) = Date.Month(DateTime.LocalNow()) and Date.Year([Date]) = Date.Year(DateTime.LocalNow()), type logical),
    #"Added YearQuarter" = Table.AddColumn(#"Added IsCurrentMonth", "YearQuarter",
        each Text.From([Year]) & "-" & [Quarter], type text)
in
    #"Added YearQuarter"
