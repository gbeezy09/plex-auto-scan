# Plex Auto Scan Change Log
### 2.2.9
- Fixed an issue with the media upgrade when multiple files exist for the same season and episode.

### 2.2.8
- Added more waiting between failed Google API requests.

### 2.2.7
- Fixed an issue where changes started at 0 instead of 1.

### 2.2.6
- Fixed an issue where media upgrade could not be performed because of Plex schema changes.

### 2.2.6
- Removed vacuum database which was causing conflicts.
- Fixed waits between execution of Google Drive API requests

### 2.2.5
- Added retries for Google API errors.

### 2.2.4
- Fixed an issue with media upgrade broken by Plex upgrade.

### 2.2.3
- Fixed an issue with listing missing media.

### 2.2.2
- Fixed an issue with detecting changes against database.

### 2.2.0
- Added option to purge detected changes. This is useful for old entries that have since been deleted.
- Added a 500ms wait time between file system checks when running trash update.
- Added database vacuum every 7 days