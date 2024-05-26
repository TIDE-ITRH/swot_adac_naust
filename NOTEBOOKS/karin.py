"""
SWOT Karin utils
"""
import matplotlib.pyplot as plt
import numpy as np
import xarray as xr

def clip_swot(ds, area):
    selection = (
        (ds.longitude > area[0]) &
        (ds.longitude < area[2]) &
        (ds.latitude > area[1]) &
        (ds.latitude < area[3]))
    selection = selection.compute()
    return ds.where(selection, drop=True)

# Remove flagged data
def apply_flag(dataflag, da, flags='good'):
    if flags == 'good':
        upperflag = 0
    elif flags == 'suspect':
        upperflag = 8192
    elif flags == 'degraded':
        upperflag = 262144
    elif flags == 'bad':
        upperflag = np.inf

    idx = dataflag <= upperflag

    return da.where(idx, np.nan)

def calc_ssha_l2_l3_dynamic(ds_l2, ds_l3, flags='good'):
    ssha = ds_l2['ssh_karin_2']\
        + ds_l2['height_cor_xover']\
        - ds_l3['mss'] \
        - ds_l2['solid_earth_tide']\
        - ds_l3['ocean_tide']\
        - ds_l2['pole_tide']\
        - ds_l2['dac']

    return apply_flag( ds_l2['ssh_karin_2_qual'], ssha, flags=flags)

def calc_ssha_l2_l3_all(ds_l2, ds_l3, flags='good'):
    ssha = ds_l2['ssh_karin_2']\
        + ds_l3['calibration']\
        - ds_l3['mss'] \
        - ds_l2['solid_earth_tide']\
        - ds_l3['ocean_tide']\
        - ds_l2['pole_tide']\
        - ds_l2['dac']

    return apply_flag( ds_l2['ssh_karin_2_qual'], ssha, flags=flags)

def process_l2_l3(l2file, l3file, flags, area=None):
    ds_l2_ = xr.open_dataset(l2file)
    ds_l3_ = xr.open_dataset(l3file)

    if area is None:
        ds_l2 = ds_l2_
        ds_l3 = ds_l3_
    else:
        ds_l2 = clip_swot(ds_l2_, area)
        ds_l3 = clip_swot(ds_l3_, area)

    ssha_l3 = ds_l3['ssha']
    ssha_l2 = apply_flag(ds_l2['ssha_karin_2_qual'],
        ds_l2['ssha_karin_2'] + ds_l2['height_cor_xover'], flags=flags)
    
    ssha_l2_l3_all = calc_ssha_l2_l3_all(ds_l2, ds_l3, flags=flags)
    ssha_l2_l3_dynamic = calc_ssha_l2_l3_dynamic(ds_l2, ds_l3, flags=flags)
    
    # Create a new dataset
    ds = xr.Dataset(
        {'ssha_l3':ssha_l3,
         'ssha_l2':ssha_l2,
         'ssha_l2_l3_all':ssha_l2_l3_all,
         'ssha_l2_l3_dynamic':ssha_l2_l3_dynamic,
         'time':ds_l2['time'],
        })
    
    ds['ssha_l2'].attrs = ds['ssha_l3'].attrs
    ds['ssha_l2'].attrs['comment'] = \
        "ds_l2['ssha_karin_2'] + ds_l2['height_cor_xover']"
    ds['ssha_l2_l3_all'].attrs['comment'] = \
        "ssha = ds_l2['ssh_karin_2']\
            + ds_l3['calibration']\
            - ds_l3['mss'] \
            - ds_l2['solid_earth_tide']\
            - ds_l3['ocean_tide']\
            - ds_l2['pole_tide']\
            - ds_l2['dac']\
        "
    ds['ssha_l2_l3_dynamic'].attrs['comment'] = \
        "ssha = ds_l2['ssh_karin_2']\
            + ds_l2['height_cor_xover']\
            - ds_l3['mss'] \
            - ds_l2['solid_earth_tide']\
            - ds_l3['ocean_tide']\
            - ds_l2['pole_tide']\
            - ds_l2['dac']\
        "
    ds.attrs = dict(
        l2_version = ds_l2.attrs['references'],
        l3_version = ds_l3.attrs['product_version'],
        l2_file = l2file,
        l3_file = l3file,
        quality_flag = flags,
    )

    return ds
    
def plot_karin(da, 
            cmap="RdBu_r",
            vmin=-0.3,
            vmax=0.3,
            fig=None,
            ax=None):

    if fig is None:
        fig, ax = plt.subplots(1, 1, figsize=(6, 4))
    plot_kwargs = dict(
    x="longitude",
    y="latitude",
    cmap=cmap,
    vmin=vmin,
    vmax=vmax,
    cbar_kwargs={"shrink": 0.3},)
    da.plot.pcolormesh(ax=ax, **plot_kwargs)
    ax.set_aspect('equal')
    #ax1.set_title(ds_area.satpass.values[ii])
    #plt.tight_layout()

def plot_karin_old(ds_area, ii,var1= 'ssha_karin', var2='ssha_karin_2', outfile=None):
        
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(6, 4))
    plot_kwargs = dict(
    x="longitude",
    y="latitude",
    cmap="RdBu_r",
    vmin=-0.3,
    vmax=0.3,
    cbar_kwargs={"shrink": 0.3},)
    ds_area.isel(satpass=ii)[var1].plot.pcolormesh(ax=ax1, **plot_kwargs)
    ds_area.isel(satpass=ii)[var2].plot.pcolormesh(ax=ax2, **plot_kwargs)
    ax1.set_title(ds_area.satpass.values[ii])
    ax2.set_title('')
    ax2.set_ylabel('')
    plt.tight_layout()

    if outfile is not None:
        plt.savefig(outfile, dpi=150)

    return fig, ax1, ax2