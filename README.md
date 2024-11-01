## qcow2_converter
# Podman Container for Converting Disk Images

This Podman container, built from the `debian:latest` image, is designed to automatically convert VHD, VHDX, and OVA files to QCOW2 format using `qemu-img`. It runs the conversion script `convert.sh` every 10 seconds to process new files in the `/data/input` directory, converting them to QCOW2 format and saving the results to `/data/output`.

## Prerequisites

- [Podman](https://podman.io/getting-started/installation) installed
- Basic knowledge of container management

## Build and Run the Container

1. **Build the container:**

    ```bash
    podman build -t image-converter .
    ```

2. **Run the container:**

    ```bash
    podman run -d -v /path/to/local/input:/data/input -v /path/to/local/output:/data/output -v  /path/to/local/complete:/data/complete image-converter
    ```

   Replace `/path/to/local/input` and `/path/to/local/output` and `/path/to/local/complete` with the paths to your local directories for input and output files.

## Directory Structure

- `/data/input`: Directory where VHD, VHDX, and OVA files should be placed for conversion.
- `/data/output`: Directory where the converted QCOW2 files will be saved.

## Configuration

The container uses a cron job to execute the `convert.sh` script every minute. The script monitors `/data/input` for new files and converts any supported files it finds, logging the process to `/var/log/convert.log`.

## convert.sh Script Overview

The `convert.sh` script performs the following steps:

1. Scans the `/data/input` directory for supported file types (`.vhd`, `.vhdx`, `.ova`, `.raw`). #will plan to add more in the future#
2. Converts each file to the QCOW2 format using `qemu-img`.
3. Logs the conversion status to `/var/log/convert.log`.


## Example Usage

1. Place a `.vhd`, `.vhdx`, or `.ova` file in `/path/to/local/input`.
2. Check the `/path/to/local/output` directory after a few seconds for the converted QCOW2 file.
3. Review the log file at `/var/log/convert.log` for details of each conversion process.

This container is configured to run the `convert.sh` script as the main process, ensuring continuous file conversion in a loop with a 10-second wait time between scans.
