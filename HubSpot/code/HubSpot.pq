// This file contains your Data Connector logic
[version = "3.0.0"]
section HubSpot;

baseUrl = "https://api.hubapi.com";

companiesSuffixUrl = "/crm/v3/objects/companies";
dealsSuffixUrl = "/crm/v3/objects/deals";
contactsSuffixUrl = "/crm/v3/objects/contacts";
productsSuffixUrl = "/crm/v3/objects/products"; // Added Products path
leadsSuffixUrl = "/crm/v3/objects/leads";
ticketsSuffixUrl = "/crm/v3/objects/tickets";
lineItemsSuffixUrl = "/crm/v3/objects/line_items";
quotesSuffixUrl = "/crm/v3/objects/quotes";
ordersSuffixUrl = "/crm/v3/objects/orders";
subscriptionsSuffixUrl = "/crm/v3/objects/subscriptions";
cartsSuffixUrl = "/crm/v3/objects/carts";
callsSuffixUrl = "/crm/v3/objects/calls";
emailsSuffixUrl = "/crm/v3/objects/emails";
meetingsSuffixUrl = "/crm/v3/objects/meetings";
notesSuffixUrl = "/crm/v3/objects/notes";
postalMailSuffixUrl = "/crm/v3/objects/postal_mail";
tasksSuffixUrl = "/crm/v3/objects/tasks";
ownersSuffixUrl = "/crm/v3/owners/";
companiesPropertiesSuffixUrl = "/crm/v3/properties/companies";
partnerNetworkApplicationsSuffixUrl = "/crm/v3/objects/0-420";
partnerNetworkApplicationsPropertiesSuffixUrl = "/crm/v3/properties/0-420";
partnerContractsSuffixUrl = "/crm/v3/objects/2-222440285";
partnerProductCommunicationDetailsSuffixUrl = "/crm/v3/objects/2-221836290";
partnerProductsAndSystemsSuffixUrl = "/crm/v3/objects/2-221830980";
coursesSuffixUrl = "/crm/v3/objects/0-410";
partnerProductReleasesSuffixUrl = "/crm/v3/objects/0-970";

companiesProperties = "name,domain,hubspot_owner_id,industry,lifecyclestage,city,state,country,website,annualrevenue,createdate,hs_lastmodifieddate,numberofemployees";
dealsProperties = "hs_forecast_amount,hs_manual_forecast_category,hs_forecast_probability,amount,amount_in_home_currency,closedate,createdate,dealname,dealstage,dealtype,pipeline,hubspot_owner_id,num_notes,num_contacted_notes,closed_lost_reason,closed_won_reason";
contactsProperties = "lead_source,gender,industry,email,hs_linkedinid,city,country,state,jobtitle,job_function,num_associated_deals,hubspot_owner_id,website,firstname,lastname,phone,hs_lead_status,hs_analytics_source,lifecyclage,associatedcompanyid,createdate";
productsProperties = "name,price,description,hs_product_type"; // Added Products properties
ownerProperties = "id,email,type,firstName,lastName,userId,userIdIncludingInactive,createdAt,updatedAt,archived";
partnerNetworkApplicationsAssociations = "companies,contacts,2-221830980,0-3,tickets";
partnerNetworkApplicationsProperties = {
    "additional_use_case_name_sync_airtablena",
    "address_1__sample_sync_airtbale",
    "address_1_sync_airtablena",
    "address_2__sample_atna",
    "airtable_record_id_sync_airtablena",
    "another_query_sync_airtablena",
    "appendix_1___evidence_that_entrant_is_a_health_care_provider__path_2___type_ii_",
    "appendix_1___evidence_that_entrant_is_a_health_care_provider__path_3___type_i_",
    "appendix_2___evidence_that_the_entrant_is_a_covered_entity_under_hipaa__path_2___type_ii_",
    "appendix_2___evidence_that_the_entrant_is_a_covered_entity_under_hipaa__path_3___type_i_",
    "appendix_3___evidence_or_information_that_the_entrant_provides_health_care_services_to_patients_thr",
    "appendix_4__patient_interaction_information__path_3_",
    "are_the_majority_users_intended_or_existing_of_your_product_covered_entity_",
    "awaiting_further_information_reason",
    "business_development_representative",
    "can_clinical_queries_in_your_solution_be_executed_by_a_single_third_party_through_your_apis_or_inte",
    "care_setting_examples_sync_airtablena",
    "care_setting_sync_airtablena",
    "care_site_address_1__sample_",
    "care_site_address_2__sample_",
    "care_site_city__sample_",
    "care_site_state__sample_",
    "care_site_zip__sample_",
    "city__sample_atna",
    "company_address_2_sync_airtablena",
    "company_city_sync_airtablena",
    "company_domain_sync_pouairtable",
    "company_name__dba_sync_airtablena",
    "company_name_sync_pouairtable",
    "company_phone_sync_airtablena",
    "company_website_sync_airtablena",
    "company_zip_sync_airtablena",
    "data_interaction_2_sync_airtablena",
    "data_interaction_sync_airtablena",
    "data_treatment_impact_2_sync_airtablena",
    "data_treatment_impact_sync_airtablena",
    "data_use_2_sync_airtablena",
    "data_use_sync_airtablena",
    "data_use_why_2_sync_airtablena",
    "data_use_why_sync_airtablena",
    "days_since_created",
    "days_since_status_last_updated",
    "dba__sample_sync_airtablene",
    "doa",
    "failure_reason",
    "first_name_sync_airtablena",
    "gravity_form_entry_id_sync_airtablena",
    "hs_created_by_user_id",
    "hs_createdate",
    "hs_lastmodifieddate",
    "hs_listing_type",
    "hs_merged_object_ids",
    "hs_name",
    "hs_object_id",
    "hs_object_source_detail_1",
    "hs_object_source_detail_2",
    "hs_object_source_detail_3",
    "hs_object_source_label",
    "hs_pipeline",
    "hs_pipeline_stage",
    "hs_shared_team_ids",
    "hs_shared_user_ids",
    "hs_updated_by_user_id",
    "hubspot_owner_assigneddate",
    "hubspot_owner_id",
    "hubspot_team_id",
    "integrated_partner_solution_id",
    "internal_logic",
    "internal_use_sync_airtablena",
    "is_your_organization_a_covered_entity",
    "kno2_partner_id",
    "kno2_partner_id_number",
    "last_name_sync_airtablena",
    "legal_name__sample_sync_airtablena",
    "legal_name_syn_airtablena",
    "medicare__medicaid__gov_health_sync_airtablena",
    "mobile_phone_number_sync_airtablena",
    "network_application_status",
    "npi__sample_",
    "office_phone_number_sync_airtablena",
    "partner_company_id",
    "path_a_edit_link",
    "path_b_edit_link",
    "path_sync_airtablena",
    "primary_use_case_name_sync_airtablena",
    "provider_type__sample_",
    "query_lookback_2_sync_airtablena",
    "query_lookback_sync_airtablena",
    "query_networks_sync_airtablena",
    "query_timing_2_sync_airtablena",
    "query_timing_sync_airtablena",
    "query_trigger_2",
    "query_trigger_sync_airtablena",
    "responding_data_description_sync_airtablena",
    "responding_data_format_sync_airtablena",
    "responding_system_sync_airtablena",
    "select_who_this_application_is_intended_for_",
    "solution_attachments",
    "solution_attachments_sync_naairtable",
    "solution_description_sync_airtablena",
    "solution_name_sync_airtablena",
    "solution_sharepoint_file_url",
    "solution_sharepoint_folder_url",
    "solution_url_sync_airtablena",
    "state__sample_",
    "state_sync_airtablena",
    "submitter_email_sync_naairtable",
    "tefca_vetting_analysis_sync_pouairtable",
    "title_sync_airtablena",
    "use_case_description_2_sync_airtablena",
    "use_case_description_sync_airtablena",
    "website_url__sample_",
    "zip__sample_"
};
partnerContractsAssociations = "0-116,0-18,0-2,0-27,0-3,0-46,0-47,0-48,0-49,0-51";
partnerContractsProperties = {
    "agreement_age_years",
    "contract_effective_date",
    "contract_execution_date",
    "contract_name",
    "hs_all_accessible_team_ids",
    "hs_all_assigned_business_unit_ids",
    "hs_all_owner_ids",
    "hs_all_team_ids",
    "hs_created_by_user_id",
    "hs_createdate",
    "hs_lastmodifieddate",
    "hs_merged_object_ids",
    "hs_object_id",
    "hs_object_source",
    "hs_object_source_detail_1",
    "hs_object_source_detail_2",
    "hs_object_source_detail_3",
    "hs_object_source_id",
    "hs_object_source_label",
    "hs_object_source_user_id",
    "hs_owning_teams",
    "hs_pinned_engagement_id",
    "hs_read_only",
    "hs_shared_team_ids",
    "hs_shared_user_ids",
    "hs_unique_creation_key",
    "hs_updated_by_user_id",
    "hs_user_ids_of_all_notification_followers",
    "hs_user_ids_of_all_notification_unfollowers",
    "hs_user_ids_of_all_owners",
    "hs_was_imported",
    "hubspot_owner_assigneddate",
    "hubspot_owner_id",
    "hubspot_team_id",
    "partner_contract"
};
partnerProductCommunicationDetailsAssociations = "0-1,0-116,0-18,0-2,0-27,0-46,0-47,0-48,0-49,0-51,0-970,2-221830980";
partnerProductCommunicationDetailsProperties = {
    "hs_all_accessible_team_ids",
    "hs_all_assigned_business_unit_ids",
    "hs_all_owner_ids",
    "hs_all_team_ids",
    "hs_created_by_user_id",
    "hs_createdate",
    "hs_lastmodifieddate",
    "hs_merged_object_ids",
    "hs_object_id",
    "hs_object_source",
    "hs_object_source_detail_1",
    "hs_object_source_detail_2",
    "hs_object_source_detail_3",
    "hs_object_source_id",
    "hs_object_source_label",
    "hs_object_source_user_id",
    "hs_owning_teams",
    "hs_pinned_engagement_id",
    "hs_read_only",
    "hs_shared_team_ids",
    "hs_shared_user_ids",
    "hs_unique_creation_key",
    "hs_updated_by_user_id",
    "hs_user_ids_of_all_notification_followers",
    "hs_user_ids_of_all_notification_unfollowers",
    "hs_user_ids_of_all_owners",
    "hs_was_imported",
    "hubspot_owner_assigneddate",
    "hubspot_owner_id",
    "hubspot_team_id",
    "modality",
    "vendor"
};
partnerProductsAndSystemsAssociations = "0-1,0-116,0-162,0-18,0-2,0-27,0-3,0-420,0-46,0-47,0-48,0-49,0-51,0-970,2-221836290";
partnerProductsAndSystemsProperties = {
    "api_access",
    "care_settings",
    "ehr_api_integration",
    "ehr_certification",
    "end_user_portal_access",
    "hs_all_accessible_team_ids",
    "hs_all_assigned_business_unit_ids",
    "hs_all_owner_ids",
    "hs_all_team_ids",
    "hs_created_by_user_id",
    "hs_createdate",
    "hs_lastmodifieddate",
    "hs_merged_object_ids",
    "hs_object_id",
    "hs_object_source",
    "hs_object_source_detail_1",
    "hs_object_source_detail_2",
    "hs_object_source_detail_3",
    "hs_object_source_id",
    "hs_object_source_label",
    "hs_object_source_user_id",
    "hs_owning_teams",
    "hs_pinned_engagement_id",
    "hs_pipeline",
    "hs_pipeline_stage",
    "hs_read_only",
    "hs_shared_team_ids",
    "hs_shared_user_ids",
    "hs_unique_creation_key",
    "hs_updated_by_user_id",
    "hs_user_ids_of_all_notification_followers",
    "hs_user_ids_of_all_notification_unfollowers",
    "hs_user_ids_of_all_owners",
    "hs_was_imported",
    "hubspot_owner_assigneddate",
    "hubspot_owner_id",
    "hubspot_team_id",
    "jira_id",
    "oid",
    "partner_brand",
    "partner_type",
    "primary_purpose",
    "product_architecture__choose_all_that_apply_",
    "product_description",
    "product_name",
    "product_system_type",
    "purpose_of_use_find",
    "purpose_of_use_respond",
    "status_with_kno2"
};
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
            {"HubSpot CRM Companies", "Companies", HubSpot.GetCompanies(), "Table", "Table", true},
            {"HubSpot CRM Contacts", "Contacts", HubSpot.GetContacts(), "Table", "Table", true},
            {"HubSpot Sales Deals", "Deals", HubSpot.GetDeals(), "Table", "Table", true},
            {"HubSpot Sales Opportunities", "Opportunities", HubSpot.GetDeals(), "Table", "Table", true},
            {"HubSpot CRM Products", "Products", HubSpot.GetProducts(), "Table", "Table", true}, // Added Products table
            {"HubSpot Sales Leads", "Leads", HubSpot.GetLeads(), "Table", "Table", true},
            {"HubSpot Service Tickets", "Tickets", HubSpot.GetTickets(), "Table", "Table", true},
            {"HubSpot Sales Line Items", "Line Items", HubSpot.GetLineItems(), "Table", "Table", true},
            {"HubSpot Sales Quotes", "Quotes", HubSpot.GetQuotes(), "Table", "Table", true},
            {"HubSpot Commerce Orders", "Orders", HubSpot.GetOrders(), "Table", "Table", true},
            {"HubSpot Commerce Subscriptions", "Subscriptions", HubSpot.GetSubscriptions(), "Table", "Table", true},
            {"HubSpot Commerce Carts", "Carts", HubSpot.GetCarts(), "Table", "Table", true},
            {"HubSpot Activities Calls", "Calls", HubSpot.GetCalls(), "Table", "Table", true},
            {"HubSpot Activities Emails", "Emails", HubSpot.GetEmails(), "Table", "Table", true},
            {"HubSpot Activities Meetings", "Meetings", HubSpot.GetMeetings(), "Table", "Table", true},
            {"HubSpot Activities Notes", "Notes", HubSpot.GetNotes(), "Table", "Table", true},
            {"HubSpot Activities Postal Mail", "Postal Mail", HubSpot.GetPostalMail(), "Table", "Table", true},
            {"HubSpot Activities Tasks", "Tasks", HubSpot.GetTasks(), "Table", "Table", true},
            {"HubSpot Custom Partner Network Application", "PartnerNetworkApplications", HubSpot.GetPartnerNetworkApplications(), "Table", "Table", true},
            {"HubSpot Custom Partner Contracts", "PartnerContracts", HubSpot.GetPartnerContracts(), "Table", "Table", true},
            {"HubSpot Custom Partner Product Communication Details", "PartnerProductCommunicationDetails", HubSpot.GetPartnerProductCommunicationDetails(), "Table", "Table", true},
            {"HubSpot Custom Partner Products and Systems", "PartnerProductsAndSystems", HubSpot.GetPartnerProductsAndSystems(), "Table", "Table", true},
            {"HubSpot Custom Courses", "Courses", HubSpot.GetCourses(), "Table", "Table", true},
            {"HubSpot Custom Partner Product Releases", "PartnerProductReleases", HubSpot.GetPartnerProductReleases(), "Table", "Table", true},
            {"HubSpot CRM Owners", "Owners", HubSpot.GetOwners(), "Table", "Table", true}
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
    firstPage =
        let
            response = Json.Document(Web.Contents(initialUrl, [ManualCredentials = true, Headers = apiHeaders])),
            results = Record.FieldOrDefault(response, "results", {}),
            nextLink = try response[paging][next][link] otherwise null
        in
            [Results = results, NextLink = nextLink],
    pages = List.Generate(
        () => firstPage,
        each _ <> null,
        each
            if [NextLink] <> null then
                let
                    response = Json.Document(Web.Contents([NextLink], [ManualCredentials = true, Headers = apiHeaders])),
                    results = Record.FieldOrDefault(response, "results", {}),
                    nextLink = try response[paging][next][link] otherwise null
                in
                    [Results = results, NextLink = nextLink]
            else
                null,
        each [Results]
    ),
    allRecords = List.Combine(List.RemoveNulls(pages))
in
    allRecords;

HubSpot.GetObjectProperties = (objectType as text) as list =>
let
    queryRecord = [archived = "false"],
    queryString = Uri.BuildQueryString(queryRecord),
    url = baseUrl & "/crm/v3/properties/" & objectType & "?" & queryString,
    accessToken = Extension.CurrentCredential()[Key],
    apiHeaders = [#"Content-Type" = "application/json", Authorization = "Bearer " & accessToken],
    Source = try Json.Document(Web.Contents(url, [ManualCredentials = true, Headers = apiHeaders])) otherwise null,
    resultsList = if Source = null then {} else Record.FieldOrDefault(Source, "results", {}),
    table = if List.IsEmpty(resultsList) then #table({"name"}, {}) else Table.FromRecords(resultsList, {"name"}),
    listOfNames = table[name]
in
    listOfNames;

HubSpot.GetObjectTable = (objectSuffixUrl as text, properties as list, associations as nullable list) as table =>
let
    propertiesQString = if List.IsEmpty(properties) then "" else List.Accumulate(properties, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    associationsQString = if associations = null or List.IsEmpty(associations) then "" else List.Accumulate(associations, "", (state, current) => state & "&associations=" & current),
    url = baseUrl & objectSuffixUrl & "?" & queryString & propertiesQString & associationsQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    defaultPropsRecord = Record.FromList(List.Repeat({null}, List.Count(properties)), properties),
    normalizedTable = if Table.IsEmpty(table) or List.IsEmpty(properties) then table else Table.TransformColumns(table, {"properties", each Record.Combine({defaultPropsRecord, _}), type record}),
    #"Expanded properties" = if Table.IsEmpty(normalizedTable) or List.IsEmpty(properties) then normalizedTable else Table.ExpandRecordColumn(normalizedTable, "properties", properties)
in
    #"Expanded properties";


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
    table = if List.IsEmpty(resultsList) then
        #table({"name", "hubspotDefined"}, {})
    else
        Table.FromRecords(List.Transform(resultsList, each [
            name = Record.FieldOrDefault(_, "name", null),
            hubspotDefined = Record.FieldOrDefault(_, "hubspotDefined", true)
        ])),
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
shared HubSpot.GetPartnerNetworkApplications = Value.ReplaceType(HubSpot.GetPartnerNetworkApplicationsImpl, HubSpot.GetPartnerNetworkApplicationsImplType);

HubSpot.GetPartnerNetworkApplicationsImplType = type function() as table meta [
    Documentation.Name = "Get Partner Network Applications",
    Documentation.LongDescription = "Retrieves all Partner Network Applications from HubSpot."
];

HubSpot.GetPartnerNetworkApplicationsImpl = () =>
let
    propertiesQString = List.Accumulate(partnerNetworkApplicationsProperties, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    associationsQString = List.Accumulate(Text.Split(partnerNetworkApplicationsAssociations, ","), "", (state, current) => state & "&associations=" & current),
    url = baseUrl & partnerNetworkApplicationsSuffixUrl & "?" & queryString & propertiesQString & associationsQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    defaultPropsRecord = Record.FromList(List.Repeat({null}, List.Count(partnerNetworkApplicationsProperties)), partnerNetworkApplicationsProperties),
    normalizedTable = if Table.IsEmpty(table) then table else Table.TransformColumns(table, {"properties", each Record.Combine({defaultPropsRecord, _}), type record}),
    #"Expanded properties" = if Table.IsEmpty(normalizedTable) then normalizedTable else Table.ExpandRecordColumn(normalizedTable, "properties", partnerNetworkApplicationsProperties)
in
    #"Expanded properties";

[DataSource.Kind="HubSpot"]
shared HubSpot.GetPartnerContracts = Value.ReplaceType(HubSpot.GetPartnerContractsImpl, HubSpot.GetPartnerContractsImplType);

HubSpot.GetPartnerContractsImplType = type function() as table meta [
    Documentation.Name = "Get Partner Contracts",
    Documentation.LongDescription = "Retrieves all Partner Contracts from HubSpot."
];

HubSpot.GetPartnerContractsImpl = () =>
let
    propertiesQString = List.Accumulate(partnerContractsProperties, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    associationsQString = List.Accumulate(Text.Split(partnerContractsAssociations, ","), "", (state, current) => state & "&associations=" & current),
    url = baseUrl & partnerContractsSuffixUrl & "?" & queryString & propertiesQString & associationsQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    defaultPropsRecord = Record.FromList(List.Repeat({null}, List.Count(partnerContractsProperties)), partnerContractsProperties),
    normalizedTable = if Table.IsEmpty(table) then table else Table.TransformColumns(table, {"properties", each Record.Combine({defaultPropsRecord, _}), type record}),
    #"Expanded properties" = if Table.IsEmpty(normalizedTable) then normalizedTable else Table.ExpandRecordColumn(normalizedTable, "properties", partnerContractsProperties)
in
    #"Expanded properties";

[DataSource.Kind="HubSpot"]
shared HubSpot.GetPartnerProductCommunicationDetails = Value.ReplaceType(HubSpot.GetPartnerProductCommunicationDetailsImpl, HubSpot.GetPartnerProductCommunicationDetailsImplType);

HubSpot.GetPartnerProductCommunicationDetailsImplType = type function() as table meta [
    Documentation.Name = "Get Partner Product Communication Details",
    Documentation.LongDescription = "Retrieves all Partner Product Communication Details from HubSpot."
];

HubSpot.GetPartnerProductCommunicationDetailsImpl = () =>
let
    propertiesQString = List.Accumulate(partnerProductCommunicationDetailsProperties, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    associationsQString = List.Accumulate(Text.Split(partnerProductCommunicationDetailsAssociations, ","), "", (state, current) => state & "&associations=" & current),
    url = baseUrl & partnerProductCommunicationDetailsSuffixUrl & "?" & queryString & propertiesQString & associationsQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    defaultPropsRecord = Record.FromList(List.Repeat({null}, List.Count(partnerProductCommunicationDetailsProperties)), partnerProductCommunicationDetailsProperties),
    normalizedTable = if Table.IsEmpty(table) then table else Table.TransformColumns(table, {"properties", each Record.Combine({defaultPropsRecord, _}), type record}),
    #"Expanded properties" = if Table.IsEmpty(normalizedTable) then normalizedTable else Table.ExpandRecordColumn(normalizedTable, "properties", partnerProductCommunicationDetailsProperties)
in
    #"Expanded properties";

[DataSource.Kind="HubSpot"]
shared HubSpot.GetPartnerProductsAndSystems = Value.ReplaceType(HubSpot.GetPartnerProductsAndSystemsImpl, HubSpot.GetPartnerProductsAndSystemsImplType);

HubSpot.GetPartnerProductsAndSystemsImplType = type function() as table meta [
    Documentation.Name = "Get Partner Products and Systems",
    Documentation.LongDescription = "Retrieves all Partner Products and Systems from HubSpot."
];

HubSpot.GetPartnerProductsAndSystemsImpl = () =>
let
    propertiesQString = List.Accumulate(partnerProductsAndSystemsProperties, "", (state, current) => if state="" then state & "&properties="&current else state & "&" & "properties="&current),
    queryRecord = [limit = pageSize],
    queryString = Uri.BuildQueryString(queryRecord),
    associationsQString = List.Accumulate(Text.Split(partnerProductsAndSystemsAssociations, ","), "", (state, current) => state & "&associations=" & current),
    url = baseUrl & partnerProductsAndSystemsSuffixUrl & "?" & queryString & propertiesQString & associationsQString,
    AllRecords = HubSpot.GetAllPages(url),
    table = Table.FromRecords(AllRecords),
    defaultPropsRecord = Record.FromList(List.Repeat({null}, List.Count(partnerProductsAndSystemsProperties)), partnerProductsAndSystemsProperties),
    normalizedTable = if Table.IsEmpty(table) then table else Table.TransformColumns(table, {"properties", each Record.Combine({defaultPropsRecord, _}), type record}),
    #"Expanded properties" = if Table.IsEmpty(normalizedTable) then normalizedTable else Table.ExpandRecordColumn(normalizedTable, "properties", partnerProductsAndSystemsProperties)
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
shared HubSpot.GetLeads = Value.ReplaceType(HubSpot.GetLeadsImpl, HubSpot.GetLeadsImplType);

HubSpot.GetLeadsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Leads",
    Documentation.LongDescription = "Retrieves all leads from HubSpot."
];

HubSpot.GetLeadsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("leads"),
    Result = HubSpot.GetObjectTable(leadsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetTickets = Value.ReplaceType(HubSpot.GetTicketsImpl, HubSpot.GetTicketsImplType);

HubSpot.GetTicketsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Tickets",
    Documentation.LongDescription = "Retrieves all tickets from HubSpot."
];

HubSpot.GetTicketsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("tickets"),
    Result = HubSpot.GetObjectTable(ticketsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetLineItems = Value.ReplaceType(HubSpot.GetLineItemsImpl, HubSpot.GetLineItemsImplType);

HubSpot.GetLineItemsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Line Items",
    Documentation.LongDescription = "Retrieves all line items from HubSpot."
];

HubSpot.GetLineItemsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("line_items"),
    Result = HubSpot.GetObjectTable(lineItemsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetQuotes = Value.ReplaceType(HubSpot.GetQuotesImpl, HubSpot.GetQuotesImplType);

HubSpot.GetQuotesImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Quotes",
    Documentation.LongDescription = "Retrieves all quotes from HubSpot."
];

HubSpot.GetQuotesImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("quotes"),
    Result = HubSpot.GetObjectTable(quotesSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetOrders = Value.ReplaceType(HubSpot.GetOrdersImpl, HubSpot.GetOrdersImplType);

HubSpot.GetOrdersImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Orders",
    Documentation.LongDescription = "Retrieves all orders from HubSpot."
];

HubSpot.GetOrdersImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("orders"),
    Result = HubSpot.GetObjectTable(ordersSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetSubscriptions = Value.ReplaceType(HubSpot.GetSubscriptionsImpl, HubSpot.GetSubscriptionsImplType);

HubSpot.GetSubscriptionsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Subscriptions",
    Documentation.LongDescription = "Retrieves all subscriptions from HubSpot."
];

HubSpot.GetSubscriptionsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("subscriptions"),
    Result = HubSpot.GetObjectTable(subscriptionsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetCarts = Value.ReplaceType(HubSpot.GetCartsImpl, HubSpot.GetCartsImplType);

HubSpot.GetCartsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Carts",
    Documentation.LongDescription = "Retrieves all carts from HubSpot."
];

HubSpot.GetCartsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("carts"),
    Result = HubSpot.GetObjectTable(cartsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetCalls = Value.ReplaceType(HubSpot.GetCallsImpl, HubSpot.GetCallsImplType);

HubSpot.GetCallsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Calls",
    Documentation.LongDescription = "Retrieves all calls from HubSpot."
];

HubSpot.GetCallsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("calls"),
    Result = HubSpot.GetObjectTable(callsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetEmails = Value.ReplaceType(HubSpot.GetEmailsImpl, HubSpot.GetEmailsImplType);

HubSpot.GetEmailsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Emails",
    Documentation.LongDescription = "Retrieves all emails from HubSpot."
];

HubSpot.GetEmailsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("emails"),
    Result = HubSpot.GetObjectTable(emailsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetMeetings = Value.ReplaceType(HubSpot.GetMeetingsImpl, HubSpot.GetMeetingsImplType);

HubSpot.GetMeetingsImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Meetings",
    Documentation.LongDescription = "Retrieves all meetings from HubSpot."
];

HubSpot.GetMeetingsImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("meetings"),
    Result = HubSpot.GetObjectTable(meetingsSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetNotes = Value.ReplaceType(HubSpot.GetNotesImpl, HubSpot.GetNotesImplType);

HubSpot.GetNotesImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Notes",
    Documentation.LongDescription = "Retrieves all notes from HubSpot."
];

HubSpot.GetNotesImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("notes"),
    Result = HubSpot.GetObjectTable(notesSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetPostalMail = Value.ReplaceType(HubSpot.GetPostalMailImpl, HubSpot.GetPostalMailImplType);

HubSpot.GetPostalMailImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Postal Mail",
    Documentation.LongDescription = "Retrieves all postal mail from HubSpot."
];

HubSpot.GetPostalMailImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("postal_mail"),
    Result = HubSpot.GetObjectTable(postalMailSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetTasks = Value.ReplaceType(HubSpot.GetTasksImpl, HubSpot.GetTasksImplType);

HubSpot.GetTasksImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Tasks",
    Documentation.LongDescription = "Retrieves all tasks from HubSpot."
];

HubSpot.GetTasksImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("tasks"),
    Result = HubSpot.GetObjectTable(tasksSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetCourses = Value.ReplaceType(HubSpot.GetCoursesImpl, HubSpot.GetCoursesImplType);

HubSpot.GetCoursesImplType = type function() as table meta [
    Documentation.Name = "Get HubSpot Courses",
    Documentation.LongDescription = "Retrieves all courses from HubSpot."
];

HubSpot.GetCoursesImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("0-410"),
    Result = HubSpot.GetObjectTable(coursesSuffixUrl, propertiesList, null)
in
    Result;

[DataSource.Kind="HubSpot"]
shared HubSpot.GetPartnerProductReleases = Value.ReplaceType(HubSpot.GetPartnerProductReleasesImpl, HubSpot.GetPartnerProductReleasesImplType);

HubSpot.GetPartnerProductReleasesImplType = type function() as table meta [
    Documentation.Name = "Get Partner Product Releases",
    Documentation.LongDescription = "Retrieves all Partner Product Releases from HubSpot."
];

HubSpot.GetPartnerProductReleasesImpl = () =>
let
    propertiesList = HubSpot.GetObjectProperties("0-970"),
    Result = HubSpot.GetObjectTable(partnerProductReleasesSuffixUrl, propertiesList, null)
in
    Result;

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
