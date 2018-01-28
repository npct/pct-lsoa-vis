#!/bin/sh
set -e

SCRIPT_DIR=$(dirname "$(readlink -f $0)")
export PATH=$PATH:${SCRIPT_DIR}

FILE=$1
RESOLUTION=$2
BARE_NAME=${FILE%.*}

if [ -z "${FILE}" ]; then
  echo "Missing file name, call using \n ./tile.sh FILE.tiff 10\nWhere 10 is the m2 per pixel"
  exit 1
fi

if [ ! -e "$FILE" ]; then
  echo "File '${FILE}' not found"
  exit 1
fi

if [ $RESOLUTION -eq 10 ]; then
  UPPER_ZOOM=15
  LOWER_ZOOM=12
elif [ $RESOLUTION -eq 50 ]; then
  UPPER_ZOOM=11
  LOWER_ZOOM=10
elif [ $RESOLUTION -eq 100 ]; then
  UPPER_ZOOM=9
  LOWER_ZOOM=5
else
  echo "Resolution must be 10, 50 or 100 but was ${RESOLUTION}"
  exit 1
fi

COLOURED=${BARE_NAME}-coloured.tiff

if [ ! -e "$COLOURED" ]; then
  echo "Colouring in the raster"
  gdaldem color-relief ${FILE} -nearest_color_entry -alpha colour.txt ${COLOURED}
fi

rm -rf ${BARE_NAME}
gdal2tiles.py ${COLOURED} -w none -z ${LOWER_ZOOM}-${UPPER_ZOOM} ${BARE_NAME}

upload.sh ${BARE_NAME}
