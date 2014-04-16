#env bash

set -ex

# =============================================================================
if { [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$#" -ne 1 ]; }; then
    echo "Convert absolute symlinks to relative ones";
	echo "usage: $0 target_file";
	echo "";
	echo "see man ln for more details";
	if [ "$#" -ne 1 ]; then
		exit 1;
	else
		exit 0;
	fi
fi

# =============================================================================

TARGET_DIR=`dirname "$1"`
TARGET=`basename "$1"`
SOURCE=`readlink "$1"`

# =============================================================================

cd $TARGET_DIR

RELATIVE_SOURCE=`python -c "\
from os.path import *;\
print relpath(\\"$SOURCE\\", abspath(dirname(\\"$TARGET\\")))"`


ln -snvf "$RELATIVE_SOURCE" "$TARGET"