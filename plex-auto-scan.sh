#!/bin/bash

dotnet PlexAutoScan.dll detect-changes --source GoogleDriveChangesAPI --processor Database --server MyPlexServer
dotnet PlexAutoScan.dll scan --source Database --server MyPlexServer