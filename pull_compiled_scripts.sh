#!/bin/bash
# This script pulls compiled scripts for the game "Skyrim Special Edition" to mod Scripts directory. 
# It is intended to be run from the mod's root directory.
# Only the scripts which mod directory has a .psc file in the Source/Scripts/,
# the corresponding .pex file will be pulled from the game's Data/Scripts/ directory to the mod's Data/Scripts/ directory.

# Parse command line arguments
# Optional argument: #                    --game-dir <path> to specify the game directory (default: ~/.steam/steam/steamapps/common/Skyrim Special Edition)

game_dir="$HOME/.steam/steam/steamapps/common/Skyrim Special Edition"

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


# For each .psc file in the mod's Source/Scripts/ directory, check if the corresponding .pex file exists in the game's Data/Scripts/ directory
# Also check if lower case version of the .pex file exists in the game's Data/Scripts/ directory
echo "Pulling compiled scripts from the game's Data/Scripts/ directory to the mod's Data/Scripts/ directory..."
for psc_file in "$mod_data_dir/Source/Scripts/"*.psc; do
    psc_filename=$(basename "$psc_file")
    pex_filename="${psc_filename%.psc}.pex"
    lower_pex_filename="${pex_filename,,}"  # Convert to lower case
    if [ -f "$game_dir/Data/Scripts/$pex_filename" ]; then
        echo "Pulling $pex_filename..."
        cp "$game_dir/Data/Scripts/$pex_filename" "$mod_data_dir/Scripts/"
    elif [ -f "$game_dir/Data/Scripts/$lower_pex_filename" ]; then
        echo "Pulling $lower_pex_filename..."
        cp "$game_dir/Data/Scripts/$lower_pex_filename" "$mod_data_dir/Scripts/"
    else
        echo "Warning: $pex_filename does not exist in the game's Data/Scripts/ directory. Skipping."
    fi
done

echo "Installation complete!"
