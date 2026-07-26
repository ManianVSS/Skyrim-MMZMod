#!/bin/bash
# This script installs the mod on steam proton for the game "Skyrim Special Edition"
# Copies data folder contents to the game's data folder and creates a backup of the original files.

# Parse command line arguments
# Optional argument: --backup to create a backup of the original files before copying the mod files
#                    --game-dir <path> to specify the game directory (default: ~/.steam/steam/steamapps/common/Skyrim Special Edition)

game_dir="$HOME/.steam/steam/steamapps/common/Skyrim Special Edition"

backup=false

if [ "$1" = "--backup" ]; then
    backup=true
    shift
fi

if [ "$1" = "--game-dir" ]; then
    if [ -z "$2" ]; then
        echo "Error: --game-dir option requires a path argument."
        exit 1
    fi
    game_dir="$2"
    shift 2
fi


# Check if the provided directory exists
if [ ! -d "$game_dir" ]; then
    echo "The provided directory does not exist. Please check the path and try again."
    exit 1
fi


# Define the mod's data folder path
mod_data_dir="$(pwd)/data"

# Check if the mod's data folder exists
if [ ! -d "$mod_data_dir" ]; then
    echo "The mod's data folder does not exist in the current directory. Please ensure you are running the script from the correct location."
    exit 1
fi  


# Perform backup if the --backup option was provided
if [ "$backup" = true ]; then
    echo "Creating a backup of the original files in the game's data folder..."
    backup_dir="$game_dir/Data_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir/Scripts"
    mkdir -p "$backup_dir/Source/Scripts"

    # cp -r "$game_dir/Data/Scripts" "$backup_dir/"
    # cp -r "$game_dir/Data/Source" "$backup_dir/"

    # Backup only the files present inside data folder of the mod, not the entire data folder of the game
    for file in "$mod_data_dir"/Scripts/*; do
        echo "Backing up $(basename "$file")..."
        if [ -f "$file" ]; then
            cp "$game_dir/Data/Scripts/$(basename "$file")" "$backup_dir/Scripts/"
        elif [ -d "$file" ]; then
            cp -r "$game_dir/Data/Scripts/$(basename "$file")" "$backup_dir/Scripts/"
        fi
    done
    for file in "$mod_data_dir"/Source/Scripts/*; do
        echo "Backing up $(basename "$file")..."
        if [ -f "$file" ]; then
            cp "$game_dir/Data/Source/Scripts/$(basename "$file")" "$backup_dir/Source/Scripts/"
        elif [ -d "$file" ]; then
            cp -r "$game_dir/Data/Source/Scripts/$(basename "$file")" "$backup_dir/Source/Scripts/"
        fi
    done

    echo "Backup created at $backup_dir."
fi

# Copy the mod's data folder contents to the game's data folder
echo "Copying mod files to the game's data folder..."
cp -r "$mod_data_dir/"* "$game_dir/Data/"

echo "Installation complete!"
