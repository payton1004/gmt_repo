#!/bin/bash

gmt set PS_MEDIA letter
gmt set PROJ_LENGTH_UNIT inch
gmt set PS_PAGE_ORIENTATION landscape
gmt set FONT_LABEL 09p
gmt set MAP_FRAME_WIDTH 4p
gmt set FONT_ANNOT_PRIMARY 12p
gmt set FONT_LABEL 12p
gmt set MAP_TICK_LENGTH_PRIMARY 0.13i

infile=./real_data.nc
outfile=real_data.ps
print_size=4

gmt grdgradient $infile -Ghillshade-grad.nc -A345 -Ne0.6 -V
gmt grdhisteq hillshade-grad.nc -Ghillshade-hist.nc -N -V
gmt grdmath hillshade-hist.nc 5 DIV = hillshade-int.nc

gmt grdimage $infile -R278/286/36/42 -JM$print_size -B2WESN -Xa1 -Yc -Cmby.cpt -V -K > $outfile
gmt grdimage $infile -R278/286/36/42 -JM$print_size -B2WESN -Xa6.5 -Yc -Ihillshade-int.nc -Cmby.cpt -V -O >> $outfile
