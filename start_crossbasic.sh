#!/bin/bash
# CrossBasic Interpreter Starter für Linux/macOS

echo "CrossBasic - Plattformübergreifender BASIC-Interpreter"
echo "========================================================"
echo

# Prüfe ob Python verfügbar ist
if ! command -v python3 &> /dev/null; then
    echo "FEHLER: Python3 ist nicht installiert."
    echo "Bitte installieren Sie Python3."
    exit 1
fi

# Prüfe ob pygame installiert ist
python3 -c "import pygame" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Pygame ist nicht installiert. Installiere pygame..."
    pip3 install pygame
    if [ $? -ne 0 ]; then
        echo "FEHLER: Pygame konnte nicht installiert werden."
        exit 1
    fi
fi

echo "Starte CrossBasic Interpreter..."
echo
python3 crossbasic.py
