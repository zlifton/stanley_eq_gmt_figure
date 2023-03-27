#!/bin/bash
# Plot two subplots showing topo, faults, seismicity, focal mechs, and InSAR data for the 3/31/2020 M6.5 Stanley earthquake.

# Variables
dem_file="/mnt/d/gmtsar_dem/1595542018.96.19.198.148_tmp/dem.grd"
#los_file="/mnt/d/stanley_sentinel_2/merge/los_mask_ll.grd"
los_file="/mnt/d/stanley_sentinel_2/merge/los_mask_ll_detrend.grd"
faults="/mnt/d/QFaults.gmt"
mainshock="stanley_eq_focalmech.txt"
aftershocks1="stanley_focal_AR_formatted.txt"
aftershocks2="xsec_aftershocks.txt"
aftershocks3="xsec_aftershocks_not_included.txt"

#  plot of stanley area
gmt begin Stanley_SRL_Fig_2 png,eps
	gmt subplot begin 1x2 -Fs16c -A+JTL #-Cs3c
		gmt basemap -Jm0/? -R-115.75/-114/43.3/45 -BWesN #-L -Tdx-115.4/43.5
		gmt grdimage $dem_file -Cdem1 -I+d
		gmt plot $faults -Wthicker,red #-U+jBL
		gmt meca $aftershocks1 -Sa0.7 -Ewhite -Gblack -C
		gmt meca $mainshock -Sc0.7c -Ewhite -Gred
		gmt colorbar -DJBC -Bx+l"Elevation (m)"

		gmt basemap -Jm0/? -R-115.75/-114/43.3/45 -BwEsN -c
		gmt grdimage $los_file -Cjet
                gmt plot $faults -Wthicker,red #-U+jBL
		gmt plot $aftershocks3 -Sp0.1c -Gwhite
		gmt plot $aftershocks2 -Sp0.1c -Gred
		gmt meca $mainshock -Sc0.7c -Ewhite -Gred
		gmt colorbar -DJBC -Bx+l"Ascending Track LOS Displacement (mm)"
	gmt subplot end
gmt end show
