#!/bin/bash
set -e  # Hentikan script jika ada perintah yang gagal
clear
echo "Starting server, wait..."
cd /home/container
neofetch --stdout
mkdir -p /home/container/playwright-browsers/chromium_headless_shell-1148
# Cek apakah browser sudah ada, jika belum unduh dan ekstrak
if [ ! -d "/home/container/playwright-browsers/chromium_headless_shell-1148/chrome-linux" ]; then
    echo "Downloading Chromium Headless Shell..."
    curl -L https://playwright.azureedge.net/builds/chromium/1148/chromium-headless-shell-linux.zip -o /home/container/playwright-browsers/chromium_headless_shell-1148.zip
    
    if [ $? -eq 0 ]; then
        echo "Download completed. Extracting files..."
        unzip -q /home/container/playwright-browsers/chromium_headless_shell-1148.zip -d /home/container/playwright-browsers/chromium_headless_shell-1148
        
        # Pastikan ekstraksi berhasil sebelum melanjutkan
        if [ $? -eq 0 ]; then
            echo "Extraction completed successfully."
            #rm /home/container/playwright-browsers/chromium_headless_shell-1148.zip
        else
            echo "Error: Extraction failed."
            exit 1
        fi
    else
        echo "Error: Failed to download Chromium Headless Shell."
        exit 1
    fi
else
    echo "Chromium Headless Shell already exists. Skipping download."
fi

# Pastikan direktori browser sudah ada


# Make internal Docker IP address available to processes
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP


# Print Node.js Version
echo "Using NodeJS:" && node -v

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Jalankan server dengan perintah yang dimodifikasi
eval ${MODIFIED_STARTUP}
