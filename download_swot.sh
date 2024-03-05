# Setup an rclone folder for "ftp-access.aviso.altimetry.fr" first
#rclone copy --progress swot:/data/Data/ALTI/DUACS_SWOT_Nadir/L3_Along_track ~/data/SWOT/
#rclone copy --progress swot:/data/Cruises/NWshelf/Bulletin REPORTS/
 
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/basic/ ./
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/UnSmoothed/ ./
#rclone lsd aviso_ftp:/data/swot_beta_products/l2_karin/l2_lr_ssh/1day_orbit/expert
#rclone lsd aviso_ftp:/data/swot_beta_products/l3_karin_nadir/1day_orbit/expert/alpha_v0_2
###
#remote=aviso_ftp:/data/swot_beta_products/l3_karin_nadir/1day_orbit/expert/alpha_v0_3
remote=aviso_ftp:/data/l3_karin_nadir/1day_orbit/expert/alpha_v0_3
local=~/data/SWOT/l3_karin_nadir_v0_3
#include="*_021_*.nc"
include="*_008_*.nc"
rclone copy -P --transfers 4 $remote --include $include $local
