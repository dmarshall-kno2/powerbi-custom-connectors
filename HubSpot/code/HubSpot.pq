// This file contains your Data Connector logic
[version = "3.0.0"]
section HubSpot;

baseUrl = "https://api.hubapi.com";

companiesSuffixUrl = "/crm/v3/objects/companies";
dealsSuffixUrl = "/crm/v3/objects/deals";
contactsSuffixUrl = "/crm/v3/objects/contacts";
productsSuffixUrl = "/crm/v3/objects/products"; // Added Products path
ownersSuffixUrl = "/crm/v3/owners/";
companiesPropertiesSuffixUrl = "/crm/v3/properties/companies";

companiesProperties = "name,domain,hubspot_owner_id,industry,lifecyclestage,city,state,country,website,annualrevenue,createdate,hs_lastmodifieddate,numberofemployees";
dealsProperties = "hs_forecast_amount,hs_manual_forecast_category,hs_forecast_probability,amount,amount_in_home_currency,closedate,createdate,dealname,dealstage,dealtype,pipeline,hubspot_owner_id,num_notes,num_contacted_notes,closed_lost_reason,closed_won_reason";
contactsProperties = "lead_source,gender,industry,email,hs_linkedinid,city,country,state,jobtitle,job_function,num_associated_deals,hubspot_owner_id,website,firstname,lastname,phone,hs_lead_status,hs_analytics_source,lifecyclage,associatedcompanyid,createdate";
productsProperties = "name,price,description,hs_product_type"; // Added Products properties
ownerProperties = "id,email,type,firstName,lastName,userId,userIdIncludingInactive,createdAt,updatedAt,archived";
pageSize = "100";

[DataSource.Kind="HubSpot", Publish="HubSpot.Publish"]
shared HubSpot.Contents = Value.ReplaceType(HubSpot.NavImpl, HubSpot.Params);

HubSpot.Params = type function() as table meta [
    Documentation.Name = Extension.LoadString("HubSpot.Contents.Name"),
    Documentation.LongDescription = Extension.LoadString("HubSpot.Contents.LongDescription")
];

HubSpot.NavImpl = () as table =>
let
    objects = #table(
        {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
        {
            {"Companies", "Companies", HubSpot.GetCompanies(), "Table", "Table", true},
            {"Contacts", "Contacts", HubSpot.GetContacts(), "Table", "Table", true},
            {"Deals", "Deals", HubSpot.GetDeals(), "Table", "Table", true},
            {"Products", "Products", HubSpot.GetProducts(), "Table", "Table", true}, // Added Products table
            {"Owners", "Owners", HubSpot.GetOwners(), "Table", "Table", true}
        }
    ),
    NavTable = HubSpot.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
in
    NavTable;

// Generic function to handle pagination and return a single list of all records.
HubSpot.GetAllPages = (initialUrl as text) as list =>
let
    accessToken = Extension.CurrentCredential()[Key],
    apiHeaders = [#"Content-Type" = "application/json", Authorization = "Bearer " & accessToken],

    pages = List.Generate(
        () => 
            let
                response = Json.Document(Web.Contents(initialUrl, [ManualCredentials = true, Headers = apiHeaders])),
                results = Record.FieldOrDefault(response, "results", {}),
                nextLink = try response[paging][next][link] otherwise null
            in
                [Results = results, NextLink = nextLink],
        each [NextLink] <> null, 
        each 
            let
                response = Json.Document(Web.Contents([NextLink], [ManualCredentials = true, Headers = apiHeaders])),
                results = Record.FieldOrDefault(response, "results", {}),
                nextLink = try response[paging][next][link] otherwise null
            in
                [Results = results, NextLink = nextLink],
        each [Results] 
    ),
    allRecords = List.Combine(pages)
in
    allRecords;


[DataSource.Kind="HubSpot"]
shared HubSpot.GetCompanies = Value.ReplaceType(HubSpot.GetCompaniesImpl, HubSpot.GetCompaniesImplType);

HubSpot.GetCompaniesImplType = type function() as table meta [
    Documentation.Name = Extension.LoadString("HubSpot.GetAccounts.Name"),
    Documentation.LongDescription = Extension.LoadString("HubSpot.GetAccounts.LongDescription")
];

Hubspot.GetCompanyCustomProperties = () =>
let
    queryRecord = [archived = "false"],
    queryString = Uri.BuildQueryString(queryRecord),
    url = baseUrl & companiesPropertiesSuffixUrl & "?" & queryString,
    accessToken = Extension.CurrentCredential()[Key],
    apiHeaders = [#"Content-Type" = "application/json", Authorization = "Bearer " & accessToken],
    Source = Json.Document(Web.Contents(url, [ ManualCredentials = true, Headers = apiHeaders])),
    resultsList = Record.FieldOrDefault(Source, "results", {}),
    table = if List.IsEmpty(resultsList) then #table({"name", "hubspotDefined"}, {}) else Table.FromRecords(resultsList),
    relevantColumns = Table.SelectColumns(table, {"name", "hubspotDefined"}),
    customPropsTable = Table.SelectRows(relevantColumns, each [hubspotDefined] = false),
    listOfNames = customPropsTable[name]
in
    listOfNames;

HubSpot.GetCompaniesImpl = () =>
let
    customProps = Hubspot.GetCompanyCustomProperties(),
    definedProps = Text.Split(companiesProperties, ","),
    finalProps = List.Distinct(List.Combine({customProps, definedProps})),
    propertiesQString = List.Accumulate(finalProps, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    url = baseUrl & companiesSuffixUrl & "?" & queryString & propertiesQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    #"Expanded properties" = if Table.IsEmpty(table) then table else Table.ExpandRecordColumn(table, "properties", finalProps)
in
    #"Expanded properties";

[DataSource.Kind="HubSpot"]
shared HubSpot.GetDeals = Value.ReplaceType(HubSpot.GetDealsImpl, HubSpot.GetDealsImplType);
HubSpot.GetDealsImplType = type function() as table meta [
    Documentation.Name = Extension.LoadString("HubSpot.GetDeals.Name"),
    Documentation.LongDescription = Extension.LoadString("HubSpot.GetDeals.LongDescription")
];

HubSpot.GetDealsImpl = () =>
let
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    propertiesQString = "&properties=" & Text.Replace(dealsProperties, ",", "&properties="),
    url = baseUrl & dealsSuffixUrl & "?" & queryString & propertiesQString & "&associations=company&associations=contact",
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    Result = if Table.IsEmpty(table) then table else
        let
            DealPropertyAsList = Text.Split(dealsProperties, ","),
            #"Expanded properties" = Table.ExpandRecordColumn(table, "properties", DealPropertyAsList),
            #"Add Company ID" = Table.AddColumn(#"Expanded properties", "companyId", each try [associations][companies][results]{0}[id] otherwise null, type text),
            #"Add Contact ID" = Table.AddColumn(#"Add Company ID", "contactId", each try [associations][contacts][results]{0}[id] otherwise null, type text),
            #"Removed associations" = Table.RemoveColumns(#"Add Contact ID", {"associations"})
        in
            #"Removed associations"
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetContacts = Value.ReplaceType( HubSpot.GetContactsImpl, HubSpot.GetContactsImplType);

HubSpot.GetContactsImplType = type function() as table meta [
    Documentation.Name = Extension.LoadString("HubSpot.GetContacts.Name"),
    Documentation.LongDescription = Extension.LoadString("HubSpot.GetContacts.LongDescription")
];
HubSpot.GetContactsImpl = () =>
let
    apiKey = Extension.CurrentCredential()[Key],
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    propertiesQString = "&properties=" & Text.Replace(contactsProperties, ",", "&properties="),
    url = baseUrl & contactsSuffixUrl & "?" & queryString & propertiesQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    ContactPropertyAsList = Text.Split(contactsProperties, ","),
    #"Expanded properties" = if Table.IsEmpty(table) then table else Table.ExpandRecordColumn(table, "properties", ContactPropertyAsList)
in
    #"Expanded properties";

// ** START: NEW PRODUCTS FUNCTION **
[DataSource.Kind="HubSpot"]
shared HubSpot.GetProducts = Value.ReplaceType(HubSpot.GetProductsImpl, HubSpot.GetProductsImplType);

HubSpot.GetProductsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Products",
    Documentation.LongDescription = "Retrieves all products from HubSpot."
];
HubSpot.GetProductsImpl = () =>
let
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    propertiesQString = "&properties=" & Text.Replace(productsProperties, ",", "&properties="),
    url = baseUrl & productsSuffixUrl & "?" & queryString & propertiesQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    ProductPropertyList = Text.Split(productsProperties, ","),
    #"Expanded properties" = if Table.IsEmpty(table) then table else Table.ExpandRecordColumn(table, "properties", ProductPropertyList)
in
    #"Expanded properties";
// ** END: NEW PRODUCTS FUNCTION **

[DataSource.Kind="HubSpot"]
shared HubSpot.GetOwners = Value.ReplaceType(HubSpot.GetOwnersImpl, HubSpot.GetOwnersImplType);

HubSpot.GetOwnersImplType = type function() as table meta [
    Documentation.Name = Extension.LoadString("HubSpot.GetOwners.Name"),
    Documentation.LongDescription = Extension.LoadString("HubSpot.GetOwners.LongDescription")
];

HubSpot.GetOwnersImpl = () =>
let
    url = baseUrl & ownersSuffixUrl,
    AllRecords = HubSpot.GetAllPages(url),
    #"Converted to Table" = Table.FromRecords(AllRecords)
in
    #"Converted to Table";

// Data Source Kind description
HubSpot = [
    TestConnection = (dataSourcePath) => { "HubSpot.Contents" },
    Authentication = [
        Key = [KeyLabel = "HubSpot Private App Access Token (this connector is developed by Ranbeer Makin)", Label = "HubSpot Access Token"]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
HubSpot.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://www.bigintsolutions.com",
    SourceImage = HubSpot.Icons,
    SourceTypeImage = HubSpot.Icons
];

HubSpot.Icons = [
    Icon16 = { Extension.Contents("HubSpotConnector16.png"), Extension.Contents("HubSpotConnector20.png"), Extension.Contents("HubSpotConnector24.png"), Extension.Contents("HubSpotConnector32.png") },
    Icon32 = { Extension.Contents("HubSpotConnector32.png"), Extension.Contents("HubSpotConnector40.png"), Extension.Contents("HubSpotConnector48.png"), Extension.Contents("HubSpotConnector64.png") }
];

// Navigation Table Helper
HubSpot.ToNavigationTable = (table as table, keyColumns as list, nameColumn as text, dataColumn as text, itemKindColumn as text, itemNameColumn as text, isLeafColumn as text) as table =>
let
    tableType = Value.Type(table),
    newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
        NavigationTable.NameColumn = nameColumn,
        NavigationTable.DataColumn = dataColumn,
        NavigationTable.ItemKindColumn = itemKindColumn,
        Preview.DelayColumn = dataColumn,
        NavigationTable.IsLeafColumn = isLeafColumn
    ],
    navigationTable = Value.ReplaceType(table, newTableType)
in
    navigationTable;