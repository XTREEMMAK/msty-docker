#!/bin/bash

echo "Checking for existing Msty installation in /config/msty..."

if [ ! -d "/config/msty" ]; then
    echo "Msty not found! Copying from /opt/msty..."
    cp -r /opt/msty /config/msty
else
    echo "Msty already installed in /config/msty."
fi

# Initialize D-Bus
echo "Starting D-Bus..."
dbus-daemon --session --fork

# Set the DISPLAY environment variable for X11
export DISPLAY=:1
export APPDIR=/config/msty

echo "Starting Msty..."
cd $APPDIR
exec ./msty --no-sandbox