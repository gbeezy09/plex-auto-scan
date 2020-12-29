# Plex Auto Scan

Plex Autoscan is a Microsoft .NET Core program that assists with importing of new media into Plex Media Server from Google Team Drives. Among other things, the program provides two distinct functions: change detection and change scanning.
 
### Change Detection
Plex Autoscan uses Google Drive API to monitor changes to Google Drive without scanning the entire drive. It uses markers to incrementally collect
changes that occured since last detection. When a new file is detected, it is checked against the Plex database and if this file is missing, 
a new scan request is stored in a local SQLite database and is available for scanning.

### Change Scanning
Plex Autoscan change scaninig function allows for scanning of media locations collected by the change detection mechanism. Scan will collect changes from the SQLite database and scan them into Plex. 

# Requirements
1. Any OS supported by .NET Core 3.1 ([link](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-windows))
1. Optional .NET Core 3.1 runtime ([link](https://dotnet.microsoft.com/download/dotnet-core/3.1)). Runtimes are bundled in the program

# Installation
1. Extract the program to a location of choice on your Plex server. This location should be writable
1. Edit `appsetings.json` configuration file (look for `REPLACE-ME` tags). You can use `appsettings.sample.json` as a guide
1. Verify locations for PlexAutoScan SQLite database and Plex database

# Usage
Usage: `dotnet PlexAutoScan.dll [command] [options]`

### General Usage
```
Options:
  -?|-h|--help    Show help information
  --log-level     Logging level (Verbose, Debug, Information, Warning, Error, Fatal)

Commands:
  detect-changes  Performs change detection of newly added media items to Google team Drive that are missing from the Plex database.
  google-export   Exports metadata of all media files from Google Team Drive to a Plex Auto Scan database.
  list-missing    Lists all media files that are present in the Plex database but are not present in the metadata database and vice versa.
  scan            Performs scans of previously captured changes.
  update-trash    Processes all items in the Plex database marked as deleted to ensure they are truly missing from the file system or metadata database and updates the deleted status accordingly.
```

### Detect Changes Usage
```
Usage: PlexAutoScan detect-changes [options]

Options:
  --log-level             Logging level. Options are: Verbose, Debug, Information, Warning, Error, Fatal.
  --case-sensitive        Whether to use case sensitive comparisons (true or false).
  --include-path          Specific path to include (can be used multiple times; accepts globs).
  --include-paths-file    File where include patterns are specified one per line.
  --exclude-path          Specific path to exclude (can be used multiple times; accepts globs).
  --exclude-paths-file    File where exclude patterns are specified one per line.
  --source                Type of source to use for getting changes. Options are: Database, Disk, GoogleDriveChangesApi.  
  --skip-bookmark-update  Skip bookmark update once changes are retrieved.
  --server                Specific server to earmark the changes to (can be used multiple times). Default is host name where the program is running.
  --processor             Type of processor to use for processing changes. Options are: Database, Api.  
  -?|-h|--help            Show help information

```

### Scan Usage
```
Usage: PlexAutoScan scan [options]

Options:
  --log-level              Logging level. Options are: Verbose, Debug, Information, Warning, Error, Fatal.
  --case-sensitive         Whether to use case sensitive comparisons (true or false).
  --include-path           Specific path to include (can be used multiple times; accepts globs).
  --include-paths-file     File where include patterns are specified one per line.
  --exclude-path           Specific path to exclude (can be used multiple times; accepts globs).
  --exclude-paths-file     File where exclude patterns are specified one per line.
  --server                 Specific server to earmark the changes to (can be used multiple times).
  --batch-size             Number of request to fetch for batch processing (default 50)
  --max-time               Maximum amount of time to run before exiting in format 10h4m19s (default is unlimited)
  --source                 Source from where to get scan requests (Database, Api)
  --disable-media-upgrade  Disables media upgrade and forces Plex to rescan on media upgrade
  -?|-h|--help             Show help information

```

# Notes
On first usage, for each Google team Drive, the program will require you to acknowledge and allow access to Google Drive API on your Google account. 
