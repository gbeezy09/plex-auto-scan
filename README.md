# plex-auto-scan

# Introduction

Plex Autoscan is a Microsoft .NET Core program that assists with importing of new media into Plex Media Server from Google Team Drives. Program provides two distinct functions: change detection and change scanning.
 
### Change Detection
Plex Autoscan uses Google Drive API to monitor changes to Google Drive without scanning the entire drive. It uses markers to incrementally collect
changes that occured since last detection. When a new file is detected, it is checked against the Plex database and if this file is missing, 
a new scan request is stored in a local SQLite database and is available for scanning.

### Change Scanning
Plex Autoscan change scaninig function allows for scanning of media locations collected by the change detection mechanism. Scan will collect changes from the SQLite database and scan them into Plex. 

# Requirements
1. Any OS supported by .NET Core 3.1 ([link](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-windows))
1. .NET Core 3.1 runtime ([link](https://dotnet.microsoft.com/download/dotnet-core/3.1))


# Installation
1. Copy program to a location of choice on your Plex server
1. Edit `appsetings.json` and `credentials.json` configuration files (look for `REPLACE-ME` tags)
1. Verify and update locations for Plex Autoscan SQLite database, Plex database and Plex Scanner

# Usage
Usage: `dotnet PlexAutoScan.dll [command] [options]`

### General Usage
```
Options:
  -?|-h|--help    Show help information
  --log-level     Logging level (Verbose, Debug, Information, Warning, Error, Fatal)

Commands:
  detect-changes  Retrieves changes from Google Drive that occured since last change detection
  scan            Performs scans of previously stored Google Drive changes
```

### Detect Changes Usage
```angular2
Usage: PlexAutoScan detect-changes [options]

Options:
  --include-path        Specific path pattern to include in change detection (can be used multiple times; accepts globs)
  --include-paths-file  File where include patterns are specified one per line
  --exclude-path        Specific path pattern to exclude in change detection (can be used multiple times; accepts globs)
  --exclude-paths-file  File where exclude patterns are specified one per line
  --case-sensitive      Whether to use case sensitive comparisons (true or false). Default is OS dependent (false on Windows and tue on Linux and macOS)
  -?|-h|--help          Show help information
```

### Scan Usage
```angular2
Usage: PlexAutoScan scan [options]

Options:
  --include-path        Specific path pattern to scan (can be used multiple times; accepts globs)
  --include-paths-file  File where include patterns are specified one per line
  --exclude-path        Specific path pattern to exclude (can be used multiple times; accepts globs)
  --exclude-paths-file  File where exclude patterns are specified one per line
  --case-sensitive      Whether to use case sensitive comparisons (true or false). Default is OS dependent
  --max-scans           Maximum number of scans to perform (default is unlimited)
  --max-retries         Only process scans where number or retries is less than the number specified (default is unlimited)
  -?|-h|--help          Show help information
```

# Notes
On first usage, program will require you to acknowledge and allow access to Google Drive API on your Google account. 
