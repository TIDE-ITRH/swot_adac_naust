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


#remote=aviso:/swot_products/l2_karin/l2_lr_ssh/PGC0/Expert/
#local=~/data/SWOT/l2_karin_v1_0
#include="cycle_[4-5]*/*_021_*.nc" # Browse
#rclone copy -P --transfers 4 $remote --include $include $local

#remote=aviso://geophysical-data-record/jason-1/ssha_gdr_e/
#local=~/data/Altimetr/Jason-1/
#include="cycle_005/*.nc" # Browse
#rclone copy -P --transfers 4 $remote --include $include $local

# Jason-1
#remote=aviso://geophysical-data-record/jason-1/ssha_gdr_e/
#local=~/data/Altimetr/Jason-1/
#include="cycle_*/*_216_*.nc" # Browse
#rclone copy -P --transfers 4 $remote --include $include $local

# Jason-2
#remote=aviso://geophysical-data-record/jason-2/ssha_gdr_d/
#local=~/data/Altimetr/Jason-2
#include="cycle_*/*_216_*.nc" # Browse
#rclone copy -P --transfers 4 $remote --include $include $local

# Jason-3
remote=aviso://geophysical-data-record/jason-3/ssha_gdr_f/
local=~/data/Altimetr/Jason-3
include="cycle_*/*_216_*.nc" # Browse
rclone copy -P --transfers 4 $remote --include $include $local





