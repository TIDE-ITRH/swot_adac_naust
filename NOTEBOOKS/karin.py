"""
SWOT Karin utils
"""
import matplotlib.pyplot as plt

def plot_karin(ds_area, ii,var1= 'ssha_karin', var2='ssha_karin_2', outfile=None):
        
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