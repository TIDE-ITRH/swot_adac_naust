# Setup an rclone folder for "ftp-access.aviso.altimetry.fr" first
#rclone copy --progress swot:/data/Data/ALTI/DUACS_SWOT_Nadir/L3_Along_track ~/data/SWOT/
#rclone copy --progress swot:/data/Cruises/NWshelf/Bulletin REPORTS/
 
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/basic/ ./
#rclone copy -P --transfers=4 aviso_ftp:/data/swot_beta_products/karin/l2_lr_ssh/UnSmoothed/ ./
