// This file contains your Data Connector logic
[Version = "1.0.0"]
section Kno2 Connector;

[DataSource.Kind="Kno2 Connector", Publish="Kno2 Connector.Publish"]
shared Kno2 Connector.Contents = (optional message as text) =>
    let
        _message = if (message <> null) then message else "(no message)",
        a = "Hello from Kno2 Connector: " & _message
    in
        a;

// Data Source Kind description
Kno2 Connector = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Anonymous = []
    ]
];

// Data Source UI publishing description
Kno2 Connector.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = Kno2 Connector.Icons,
    SourceTypeImage = Kno2 Connector.Icons
];

Kno2 Connector.Icons = [
    Icon16 = { Extension.Contents("Kno2 Connector16.png"), Extension.Contents("Kno2 Connector20.png"), Extension.Contents("Kno2 Connector24.png"), Extension.Contents("Kno2 Connector32.png") },
    Icon32 = { Extension.Contents("Kno2 Connector32.png"), Extension.Contents("Kno2 Connector40.png"), Extension.Contents("Kno2 Connector48.png"), Extension.Contents("Kno2 Connector64.png") }
];
