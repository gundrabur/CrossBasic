#!/usr/bin/env python3
"""
Setup script for cx_Freeze to build CrossBasic executables
"""

import sys
from cx_Freeze import setup, Executable

# Dependencies
build_exe_options = {
    "packages": ["pygame", "os", "sys", "re", "math", "random", "time", "threading"],
    "excludes": ["tkinter", "matplotlib", "numpy"],
    "include_files": [
        ("examples/", "examples/"),
        ("README.md", "README.md"),
        ("LICENSE", "LICENSE")
    ],
    "optimize": 2,
}

# Base for GUI applications (no console window)
base = None
if sys.platform == "win32":
    base = "Console"  # Keep console for BASIC interpreter

# Executable configuration
executables = [
    Executable(
        "crossbasic.py",
        base=base,
        target_name="crossbasic" if sys.platform != "win32" else "crossbasic.exe",
        icon=None  # Add icon file if you have one
    )
]

setup(
    name="CrossBasic",
    version="1.0",
    description="Cross-Platform BASIC Interpreter",
    author="Christian Moeller",
    options={"build_exe": build_exe_options},
    executables=executables
)
