# ADB Rescue Tool

**Extract data from failing Android phones and corrupted SD cards.**

When a phone or SD card is dying, standard `adb pull /sdcard/` will crash the moment it hits a corrupted file, leaving you with only half your data. 

This script solves that by scanning every file individually. If a file is corrupted, it skips it and keeps going. It also skips files you already downloaded, so you can resume after a crash or power outage.

## How it works
1. Finds every single file in the target directory.
2. Creates the exact folder structure on your computer.
3. Pulls files one-by-one (with a small delay to prevent CPU crashes).
4. Skips corrupted files and prints errors without stopping.

## Usage

1. Connect your Android device and ensure USB Debugging is enabled.
2. Find your SD card or storage path (e.g., `adb shell ls /storage/`).
3. Run the script:

```bash
./rescue.sh /storage/XXXX-XXXX ~/Recovered_Data
```

## Real-World Test
This tool was built during the recovery of an 8-year-old iBall tablet SD card. Standard ADB crashed immediately. This script successfully recovered **17,795 files (26 GB)** over a 12-hour period, surviving a mid-transfer power outage.

## Requirements
- `adb``` (Android Debug Bridge)
- Bash
