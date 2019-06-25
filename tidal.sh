#!/bin/bash
echo "Starting TidalCicles..."
set -euf -o pipefail

# Get current directory (of script)
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
function setdir {
  local source="${BASH_SOURCE[0]}"

  # Resolve $SOURCE until the file is no longer a symlink
  while [ -h "$source" ]; do
    dir="$( cd -P "$( dirname "$source" )" && pwd )"
    source="$(readlink "$source")"

    # If $SOURCE was a relative symlink, we need to resolve it relative to the
    # path where the symlink file was located
    [[ $source != /* ]] && source="$DIR/$source"
  done
  DIR="$( cd -P "$( dirname "$source" )" && pwd )"
}

setdir

TIDAL_BOOT_PATH=${TIDAL_BOOT_PATH:-"$DIR/Tidal.ghci"}
GHCI=${GHCI:-"ghci"}

# Run GHCI and load Tidal bootstrap file
$GHCI -ghci-script $TIDAL_BOOT_PATH "$@"
