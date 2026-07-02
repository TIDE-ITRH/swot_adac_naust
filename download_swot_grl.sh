#####
# Download unsmoothed SWOT data
#
# This requires configuring ftp-access.aviso.altimetry.fr as the aviso: drive in rclone
#####
MYGROUP=~/

local=/data/SWOT_Cruise/GRL_archive/SWOT/

PASS=021

for CYCLE in 500 501 502 503 504 511 513 514 515 521 523 524 532 533;do
    include="cycle_"$CYCLE"/*_"$PASS"_*.nc"
    echo $include

    # Unsmoothed
    remote=aviso:/swot_products/l2_karin/l2_lr_ssh/PGC0/Unsmoothed/
    rclone copy -P --transfers 1 $remote --include $include $local
    #
    # Smoothed
    remote=aviso:/swot_products/l2_karin/l2_lr_ssh/PGC0/Expert/
    rclone copy -P --checkers 1 --transfers 1 $remote --include $include $local
done
