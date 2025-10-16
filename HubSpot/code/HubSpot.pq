[version = "3.0.0"]
section HubSpot;

// ======================================================================
// Kno2 HubSpot Connector  (Key auth, cursor pagination, polyfills)
// ======================================================================

baseUrl = "https://api.hubapi.com";

// ------------------------------
// Exported entry point
// ------------------------------
[DataSource.Kind="Kno2HubSpot", Publish="Kno2HubSpot.Publish"]
shared HubSpot.Contents = () as table =>
let
    client = HubSpot.CreateClient(),
    nav    = HubSpot.Navigation(client)
in
    nav;

// ------------------------------
// Connector metadata (reuse Key auth)
// ------------------------------
Kno2HubSpot = [
    // Returning the function name to execute for the handshake
    TestConnection = (dataSourcePath) as list => { "HubSpot.TestConnection" },

    // Same pattern as original: Feed Key / Private App Token
    Authentication = [ Key = [ KeyLabel = "Private App Access Token" ] ],

    Label = "Kno2 HubSpot Connector"
];

Kno2HubSpot.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { "Kno2 HubSpot Connector", "Kno2 HubSpot Connector" },
    LearnMoreUrl = "https://developers.hubspot.com/docs/api/crm/understanding-the-crm",
    SourceImage = HubSpot.Icons,
    SourceTypeImage = HubSpot.Icons
];

HubSpot.Icons = [
    // reuse your existing icon files
    Icon16 = { Extension.Contents("HubSpotConnector16.png") },
    Icon20 = { Extension.Contents("HubSpotConnector20.png") },
    Icon24 = { Extension.Contents("HubSpotConnector24.png") },
    Icon32 = { Extension.Contents("HubSpotConnector32.png") },
    Icon40 = { Extension.Contents("HubSpotConnector40.png") },
    Icon48 = { Extension.Contents("HubSpotConnector48.png") },
    Icon64 = { Extension.Contents("HubSpotConnector64.png") },
    Icon80 = { Extension.Contents("HubSpotConnector80.png") }
];

// ======================================================================
// Polyfills for engines/tooling that lack these helpers
// ======================================================================

// Replacement for Table.GenerateByPage
HubSpot.GenerateByPage = (getNextPage as function) as table =>
let
    pages =
        List.Generate(
            () => [ prev = null, page = getNextPage(null) ],
            each _[page] <> null,
            each [ prev = _[page], page = getNextPage(_[page]) ],
            each _[page]
        ),
    out = if List.IsEmpty(pages) then #table({}, {}) else Table.Combine(pages)
in
    out;

// Replacement for Table.ToNavigationTable
HubSpot.ToNavigationTable =
    (table as table, keyColumns as list, nameColumn as text, dataColumn as text, itemKindColumn as text, itemNameColumn as text) as table =>
let
    step1 = if nameColumn <> "Name" then Table.RenameColumns(table, {{nameColumn, "Name"}}) else table,
    step2 = if dataColumn <> "Data" then Table.RenameColumns(step1, {{dataColumn, "Data"}}) else step1,
    step3 = if itemKindColumn <> "ItemKind" then Table.RenameColumns(step2, {{itemKindColumn, "ItemKind"}}) else step2,
    step4 =
        if List.Contains(Table.ColumnNames(step3), itemNameColumn) and itemNameColumn <> "Name" then
            Table.RenameColumns(step3, {{itemNameColumn, "ItemName"}})
        else if not List.Contains(Table.ColumnNames(step3), "ItemName") then
            Table.AddColumn(step3, "ItemName", each [Name], type text)
        else
            step3,
    kept  = Table.SelectColumns(step4, {"Name","Data","ItemKind","ItemName"}),
    nav   = kept meta [ IsNavigationTable = true ]
in
    nav;

// ======================================================================
// HTTP client + paging helpers
// ======================================================================
HubSpot.CreateClient = () as record =>
let
    token = Extension.CurrentCredential()[Key], // Key auth (Feed Key)
    auth  = "Bearer " & token,

    GetJson = (relativePath as text, optional query as nullable record) as record =>
        Json.Document(
            Web.Contents(
                baseUrl & relativePath,
                [
                    Headers = [
                        Authorization = auth,
                        Accept        = "application/json",
                        #"User-Agent"  = "PowerQuery-Connector"
                    ],
                    Query = if query = null then [] else query
                ]
            )
        ),

    // Generic cursor-paged list reader ({results=[...], paging.next.after})
    PagedGet = (relativePath as text, optional query as nullable record) as table =>
    let
        PageSize   = 100,
        BuildQuery = (after as nullable text) as record =>
            Record.Combine({
                if query = null then [] else query,
                [ limit = Text.From(PageSize) ],
                if after <> null then [ after = after ] else [],
                [ archived = "false" ]
            }),

        GetPage = (prev as nullable table) as nullable table =>
            let
                after     = if prev = null then null else Value.Metadata(prev)[After],
                json      = GetJson(relativePath, BuildQuery(after)),
                items     = if Record.HasFields(json, "results") then json[results] else {},
                tbl       = if List.IsEmpty(items) then #table({}, {}) else Table.FromRecords(items),
                nextAfter = try json[paging][next][after] otherwise null,
                out       = if Table.RowCount(tbl) = 0 then null else tbl meta [ After = nextAfter ]
            in
                out,

        Pages = HubSpot.GenerateByPage(GetPage)
    in
        Pages,

    // Variant for endpoints that may return "items" or don’t support 'archived' flag
    PagedGetSimple = (relativePath as text, optional query as nullable record) as table =>
    let
        PageSize   = 100,
        BuildQuery = (after as nullable text) as record =>
            Record.Combine({
                if query = null then [] else query,
                [ limit = Text.From(PageSize) ],
                if after <> null then [ after = after ] else []
            }),

        GetPage = (prev as nullable table) as nullable table =>
            let
                after     = if prev = null then null else Value.Metadata(prev)[After],
                json      = GetJson(relativePath, BuildQuery(after)),
                items     =
                    if Record.HasFields(json, "results") then json[results]
                    else if Record.HasFields(json, "items") then json[items]
                    else {},
                tbl       = if List.IsEmpty(items) then #table({}, {}) else Table.FromRecords(items),
                nextAfter = try json[paging][next][after] otherwise null,
                out       = if Table.RowCount(tbl) = 0 then null else tbl meta [ After = nextAfter ]
            in
                out,

        Pages = HubSpot.GenerateByPage(GetPage)
    in
        Pages
in
    [
        GetJson        = GetJson,
        PagedGet       = PagedGet,
        PagedGetSimple = PagedGetSimple,
        AuthHeader     = auth
    ];

// ======================================================================
// TestConnection (prevents endless spinner)
// ======================================================================
shared HubSpot.TestConnection = (optional dataSourcePath as any) as list =>
let
    token = Extension.CurrentCredential()[Key],
    auth  = "Bearer " & token,
    _ping = Web.Contents(
        "https://api.hubapi.com/crm/v3/owners",
        [ Headers = [ Authorization = auth, Accept = "application/json" ], Query = [ limit = "1" ] ]
    )
in
    { true };

// ======================================================================
// Object fetchers + Navigation
// ======================================================================
HubSpot.PathForObject = (object as text) as text =>
    if object = "owners" then
        "/crm/v3/owners"
    else
        "/crm/v3/objects/" & object;

HubSpot.FetchObject = (object as text, client as record, optional properties as nullable list) as table =>
let
    path   = HubSpot.PathForObject(object),
    query  = if properties <> null and List.Count(properties) > 0
             then [ properties = Text.Combine(List.Transform(properties, each _), ",") ]
             else [],
    table  = client[PagedGet](path, query)
in
    table;

HubSpot.FetchPipelines = (objectType as text, client as record) as table =>
let
    path  = "/crm/v3/pipelines/" & objectType,
    table = client[PagedGetSimple](path, [])
in
    table;

HubSpot.Navigation = (client as record) as table =>
let
    Objects =
        {
            "contacts", "companies", "deals", "tickets",
            "owners",
            "products", "line_items", "quotes",
            "feedback_submissions",
            "goals",
            "tasks", "calls", "emails", "meetings", "notes"
        },

    ObjectRows =
        List.Transform(
            Objects,
            (o as text) => [
                Name = Text.Proper(Text.Replace(o, "_", " ")),
                Kind = "Table",
                Data = HubSpot.FetchObject(o, client, null)
            ]
        ),

    PipelineRows =
        List.Transform(
            { "deals", "tickets" },
            (o as text) => [
                Name = "Pipelines - " & Text.Proper(o),
                Kind = "Table",
                Data = HubSpot.FetchPipelines(o, client)
            ]
        ),

    Rows = List.Combine({ ObjectRows, PipelineRows }),
    NavTableRaw = #table(type table [ Name = text, Kind = text, Data = any ], Rows),

    Nav = HubSpot.ToNavigationTable(
        NavTableRaw,
        {"Name"},      // key
        "Name",        // name column
        "Data",        // data column
        "Kind",        // item kind column
        "Name"         // item name column
    )
in
    Nav;