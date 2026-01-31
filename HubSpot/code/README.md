HubSpot connector (code)
========================

This folder contains the Power Query connector source and helper build scripts for the Kno2 HubSpot connector.

Quick local build & test
------------------------

1. Open PowerShell in this folder (`HubSpot\\code`).
2. Run the helper build script (it uses MakePQX to compile a `.mez` and copies outputs):

   ```powershell
   .\\build-desktop.ps1
   ```

3. The script will create `Kno2HubSpotConnector.mez` on your Desktop (OneDrive) and copy it to:

   - `C:\\Users\\<you>\\OneDrive - Kno2\\Desktop\\Kno2HubSpotConnector.mez`
   - `%USERPROFILE%\\Documents\\Power BI Desktop\\Custom Connectors\\Kno2HubSpotConnector.mez`
   - `code\\bin\\AnyCPU\\Debug\\Kno2HubSpotConnector.mez`

4. To run the test-connection locally with PQTest (Power Query SDK):

   Replace the path to PQTest.exe as needed on your machine, then run:

   ```powershell
   & 'C:\\path\\to\\PQTest.exe' test-connection --extension "C:\\Users\\<you>\\OneDrive - Kno2\\Desktop\\Kno2HubSpotConnector.mez" --queryFile "..\\HubSpotConnector.query.pq" --prettyPrint
   ```

5. If PQTest reports missing credentials, set the HubSpot token first:

   ```powershell
   @'
   {
     "AuthenticationKind": "Key",
     "AuthenticationProperties": {
       "Key": "<YOUR_PRIVATE_APP_ACCESS_TOKEN>"
     },
     "PrivacySetting": "None"
   }
   '@ | & 'C:\\path\\to\\PQTest.exe' set-credential --extension "C:\\Users\\<you>\\OneDrive - Kno2\\Desktop\\Kno2HubSpotConnector.mez" --dataSourceKind "HubSpot" --dataSourcePath "HubSpot"
   ```

Notes
-----

- `Extension.*` helpers (e.g., `Extension.CurrentCredential`, `Extension.Contents`) are resolved by the Power Query host at runtime; local editors may show lint warnings.
- CI runners may not have MakePQX or the Power Query SDK installed; the included GitHub Actions workflow attempts to download the SDK but the step is optional and conservative.
- Postman examples and captured responses live under `docs/postman` for verifying API visibility. The collection is `docs/postman/HubSpot-Partner-Network-Application.postman_collection.json`.

Included tables
---------------

- Companies
- Contacts
- Deals
- Opportunities (alias of Deals)
- Products
- Leads
- Tickets
- Line Items
- Quotes
- Orders
- Subscriptions
- Carts
- Calls
- Emails
- Meetings
- Notes
- Postal Mail
- Tasks
- Courses
- Partner Product Releases
- Partner Network Application (custom object `0-420`, static property list from `Partner Network Application-2026-01-07.zip`/`listing.csv`, associations: companies, contacts, `2-221830980`, `0-3`, tickets)
- Partner Contracts (custom object `2-222440285`, static property list from `docs/postman/List Schemas (confirm object detail)`, associations: `0-116`, `0-18`, `0-2`, `0-27`, `0-3`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`)
- Partner Product Communication Details (custom object `2-221836290`, static property list from `docs/postman/List Schemas (confirm object detail)`, associations: `0-1`, `0-116`, `0-18`, `0-2`, `0-27`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`, `0-970`, `2-221830980`)
- Partner Products and Systems (custom object `2-221830980`, static property list from `docs/postman/List Schemas (confirm object detail)`, associations: `0-1`, `0-116`, `0-162`, `0-18`, `0-2`, `0-27`, `0-3`, `0-420`, `0-46`, `0-47`, `0-48`, `0-49`, `0-51`, `0-970`, `2-221836290`)
- Owners

Troubleshooting
---------------

- If Postman returns records for a custom object but the connector returns 0 rows, ensure pagination returns the first page even when `paging.next` is absent. The connector's pagination helper now includes the initial page and only stops when `paging.next` is null.
