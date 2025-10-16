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

Notes
-----

- `Extension.*` helpers (e.g., `Extension.CurrentCredential`, `Extension.Contents`) are resolved by the Power Query host at runtime; local editors may show lint warnings.
- CI runners may not have MakePQX or the Power Query SDK installed; the included GitHub Actions workflow attempts to download the SDK but the step is optional and conservative.
