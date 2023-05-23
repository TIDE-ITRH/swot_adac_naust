# Setup an rclone folder for "ftp-access.aviso.altimetry.fr" first
rclone copy --progress swot:/data/Data/ALTI/DUACS_SWOT_Nadir/L3_Along_track ~/data/SWOT/
rclone copy --progress swot:/data/Cruises/NWshelf/Bulletin REPORTS/
 
