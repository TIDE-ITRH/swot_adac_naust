# Setup an rclone folder for "ftp-access.aviso.altimetry.fr" first
#rclone copy --progress swot:/data/Data/ALTI/DUACS_SWOT_Nadir/L3_Along_track ~/data/SWOT/
#rclone copy --progress swot:/data/Cruises/NWshelf/Bulletin REPORTS/
 
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/basic/ ./
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/UnSmoothed/ ./
#rclone lsd aviso_ftp:/data/swot_beta_products/l2_karin/l2_lr_ssh/1day_orbit/expert
#rclone lsd aviso_ftp:/data/swot_beta_products/l3_karin_nadir/1day_orbit/expert/alpha_v0_2
###
#remote=aviso_ftp:/data/swot_beta_products/l3_karin_nadir/1day_orbit/expert/alpha_v0_3
#remote=aviso_ftp:/data/l3_karin_nadir/1day_orbit/expert/alpha_v0_3
#local=~/data/SWOT/l3_karin_nadir_v0_3
##include="*_021_*.nc"
#include="*_008_*.nc"
#rclone copy -P --transfers 4 $remote --include $include $local

#remote=aviso_ftp:/data/l3_karin_nadir/1day_orbit/expert/alpha_v0_3
#remote=aviso:/swot_products/l3_karin_nadir/l3_lr_ssh/v1_0/Expert/
#local=~/data/SWOT/l3_karin_nadir_v1_0
#include="cycle_0*/*_062_*.nc" # Ningaloo
#include="cycle_0*/*_131_*.nc" # Ningaloo
#include="cycle_5*/*_021_*.nc" # Browse
#include="cycle_4*/*_021_*.nc" # Browse
#include="cycle_4*/*_008_*.nc" # Pilbara
#include="cycle_5*/*_008_*.nc" # Pilbara
#rclone copy -P --transfers 4 $remote --include $include $local


#remote=aviso:/swot_products/l2_karin/l2_lr_ssh/PGC0/Unsmoothed/
#local=~/data/SWOT/l2_karin_unsmoothed
#include="cycle_0*/*_062_*.nc" # Exmouth (cross-shore)
#include="cycle_0*/*_131_*.nc" # Exmouth (along-shore)
#rclone copy -P --transfers 4 $remote --include $include $local

remote=aviso:/swot_products/l2_karin/l2_lr_ssh/PGC0/Expert/
local=~/data/SWOT/l2_karin_v1_0
include="cycle_[4-5]*/*_021_*.nc" # Browse
rclone copy -P --transfers 4 $remote --include $include $local


