# Raspberry Pi 3 Auto-Server Setup

This project provides an optimized set of configuration files and scripts for a Raspberry Pi 3 server, providing a basic HTTP landing page and automated setup.

## Project Overview

*   **Target Platform:** Raspberry Pi 3 (B, B+, CM3).
*   **Core Functionality:** 
    *   Automatic WiFi configuration using `octopi-wpa-supplicant.txt`.
    *   One-time system initialization (updates, dependency installation).
    *   Automatic startup of a Python-based HTTP server on port 8000.

## Architecture and Key Files

### Boot & Kernel (Pi 3 Compatible)
- `bootcode.bin`, `start.elf`, `fixup.dat`: Essential bootloader files.
- `kernel7.img`, `kernel8.img`: 32-bit and 64-bit kernels for Pi 3.
- `bcm2710-rpi-3-b.dtb`, `bcm2710-rpi-3-b-plus.dtb`: Hardware descriptors for Pi 3 models.
- `config.txt`, `cmdline.txt`: Core RPi configuration.

### Automation Scripts
- `auto_setup.sh`: Main initialization script (runs once).
- `start_server.sh`: Script that launches the HTTP server and generates `index.html`.

### Systemd Services
- `initial-setup.service`: Triggers `auto_setup.sh` on the first boot.
- `http-server.service`: Manages the persistent HTTP server on port 8000.

### Network Configuration
- `octopi-wpa-supplicant.txt`: WiFi credentials (SSID/PSK).

## Setup and Usage

1.  **Preparation:** Flash a standard Raspberry Pi OS image.
2.  **Deployment:** Copy these files into the `/boot` partition of the SD card.
3.  **Configuration:** Edit `octopi-wpa-supplicant.txt` with your WiFi details.
4.  **First Boot:** Power on the Pi. It will perform updates and reboot automatically.
5.  **Access:**
    -   **Web Server:** `http://<pi-ip>:8000`
    -   **SSH:** `ssh pi@<pi-ip>` (default pass: `raspberry`)
