# Plex Auto Scan

Plex Auto Scan is a Microsoft .NET Core program that assists with importing of new media into Plex Media Server from Google Team Drives. Among other things, the program provides two distinct functions: change detection and change scanning.

### Change Detection
Plex Auto Scan uses Google Drive API to monitor changes to Google Drive without scanning the entire drive. It uses markers to incrementally collect
changes that occured since last detection. When a new file is detected, it is checked against the Plex database and if this file is missing,
a new scan request is stored in a local SQLite database and is available for scanning.

### Change Scanning
Plex Auto Scan change scanning function allows for scanning of media locations collected by the change detection mechanism. Scan will collect changes from the SQLite database and scan them into Plex.

# Requirements
1. Any OS supported by .NET Core 3.1 ([link](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-windows))
1. Optional .NET Core 3.1 runtime ([link](https://dotnet.microsoft.com/download/dotnet-core/3.1)). Runtimes are bundled in the program

# Installation
1. Extract the program to a location of choice on your Plex server. This location should be writable
1. Edit `appsetings.json` configuration file (look for `REPLACE-ME` tags). You can use `appsettings.sample.json` as a guide
1. Edit the `plex-auto-scan.bat` or `plex-auto-scan.sh` based on your OS to update the `--server` argument to match the name of your Plex server as specified in `appsettings.json`
1. Verify locations for PlexAutoScan SQLite database (if missing, new database will be created on startup) and Plex database. Use `/` as a path separator to avoid escaping backslashes.


# Usage
Scripts are provided that will run change detection and scan them in. You will need to set the `--server` parameter to match the Plex server name in `appsettings.json`


### General Usage
```
Usage: dotnet PlexAutoScan.dll [command] [options]

Options:
  -?|-h|--help    Show help information
  --log-level     Logging level (Verbose, Debug, Information, Warning, Error, Fatal)

Commands:
  detect-changes  Performs change detection of newly added media items to Google team Drive that are missing from the Plex database.
  google-export   Exports metadata of all media files from Google Team Drive to a Plex Auto Scan database.
  list-missing    Lists all media files that are present in the Plex database but are not present in the metadata database and vice versa.
  purge-changes   Performs a purge of changes stored in the database.
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
  --skip-bookmark-update  Skip bookmark update once changes are retrieved. bookmark is used to determine which changes have already been processed.
  --server                Specific server to earmark the changes to (can be used multiple times). Default is host name where the program is running.
  --processor             Type of processor to use for processing changes. Options are: Database, Api.  
  -?|-h|--help            Show help information.

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
  --server                 Specific server whose changes will be processed.
  --batch-size             Number of request to fetch for batch processing (default 50).
  --max-time               Maximum amount of time to run before exiting in format 10h4m19s (default is unlimited).
  --source                 Source from where to get scan requests (Database, Api).
  --disable-media-upgrade  Disables media upgrade and forces Plex to rescan on media upgrade.
  -?|-h|--help             Show help information.
```

#### Media Upgrades
When Sonarr, Radarr or manual process upgrades a media file from lower to higher quality or to a more preferred release, Plex Auto Scan can detect this situation and
perform direct replacement of the media file in the Plex database without additional scanning. This is done by updating references in the Plex database to point
to a new file and removing some metadata related to the old media file (resolution, bitrate, etc). Plex will regenerate this metadata when the file is viewed
for the first time after the upgrade.

If you prefer, you can disable this feature using the `--disable-media-upgrade` flag and force Plex to rescan and find the changes.

#Running For The First Time
It is required to run the app first time manually from the command line so that access token is generated and stored. For each Google Team Drive, the program
will require you to acknowledge and allow access to Google Drive API on your account.

# Scheduled Runs
You can schedule the included script to run every hour for example using cron or Windows Task Scheduler. Program will find any new or changed media since
the last time it ran that and scan them to Plex.
