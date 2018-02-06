#!/bin/bash

# /data/tiles is shared volume with api component
cd /data/tiles || exit 1

wget -c https://s3.amazonaws.com/mapbox/osm-qa-tiles-production/latest.planet.mbtiles.gz
gunzip latest.planet.mbtiles.gz

if [ "$GENERATE_UNDERZOOM" = "1" ]; then
  mv latest.planet.tiles tmp.mbtiles

  tippecanoe-decode tmp.mbtiles | tippecanoe -f -pf -pk -ps -b0 --no-tile-stats -l osm -Z0 -z12 -o tiles.processed.mbtiles

  rm tmp.mbtiles

  mv tiles.processed.mbtiles tiles.mbtiles
else
  mv latest.planet.tiles tiles.mbtiles
fi
