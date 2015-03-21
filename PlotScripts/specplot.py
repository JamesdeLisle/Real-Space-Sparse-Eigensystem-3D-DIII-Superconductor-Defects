import sys
import os
import numpy
from pylab import *
import matplotlib.gridspec as gridspec
from operator import add
from mpl_toolkits.axes_grid1.inset_locator import inset_axes
from matplotlib.patheffects import withStroke

from matplotlib import rc
rc('font',**{'family':'sans-serif','sans-serif':['Helvetica']})
## for Palatino and other serif fonts use:
#rc('font',**{'family':'serif','serif':['Palatino']})
rc('text', usetex=True)
matplotlib.rcParams.update({'font.size': 42})

fig = figure(num=None, figsize=(17,6.45),dpi=80)

gs = gridspec.GridSpec(1,2,width_ratios=[1,1])

#,height_ratios=[1.5,1]
#fig.tight_layout()


ax1 = plt.subplot(gs[0])
#ax2 = plt.subplot(gs[1])
#ax3 = plt.subplot(gs[2:])


#ax1 = plt.subplot2grid((2,2),(0,0))
#ax2 = plt.subplot2grid((2,2),(0,1))
#ax3 = plt.subplot2grid((2,2),(1,0),colspan=2)


def alternative_formatter(x,ind):

	rm = np.mod(x,1)
	
	if np.abs(rm) < 0.1:
		
		return r'${:d}$'.format(int(x))


	return r'${:.1f}$'.format(rm)		


def alternative_formatter1(x,ind):

	rm = np.mod(x,1)
	
	if np.abs(rm) < 0.05:
		
		return r'${:d}$'.format(int(x))


	elif np.abs(rm) < 0.1:
	
		return r'$0.05$'.format(rm)

	else:

		return r'${:.1f}$'.format(rm)

def gapdensity():

	data = []
	data2 = []



	inE = 'SpecDataZee.txt'
	myfile = open(inE)
	for line in myfile:
	    if line.startswith('#'):
		continue
	    else:
		line = line.strip() # like chomp in perl
		fields = line.split()
		data.append(fields[0])
		data2.append(fields[1])       
	    
	    
	ax1.scatter(data, data2, color='blue', marker=".")
	
	

	ax1.locator_params(axis='x',nbins=3)
	ax1.locator_params(axis='y',nbins=5)
	
	
	
	ax1.tick_params(labelsize=22)
	#ax1.set_xlabel(r'$B_{y}$',fontsize=25)
	ax1.set_ylabel(r'$E$',rotation='horizontal',fontsize=25)
	ax1.set_xlim([0,5600])
	a = float(min(data2))
	b = float(max(data2))
	ax1.set_ylim([-b,b])
	plt.setp(ax1.get_xticklabels(), visible=False)
	#ax1.set_xticks([0,0.25,0.5])
	#ax1.set_yticks([0,0.25,0.5])
	#ax1.xaxis.set_major_locator(MultipleLocator(.1))
	#ax1.xaxis.set_major_formatter(FuncFormatter(alternative_formatter))
	#ax1.yaxis.set_major_locator(MultipleLocator(.1))
	#ax1.yaxis.set_major_formatter(FuncFormatter(alternative_formatter))
	##a3.yaxis.set_label_coords(-0.03,0.73)
	#ax1.tick_params(axis='both',which='both',labelbottom='off',labelleft='off') 
	##1ax3.tick_params(axis='y',which='both',left='off',labelbottom='off') 
	#ax1.yaxis.set_label_coords(0.28, 0.89)
	#ax1.annotate(r"$0.5$",xy=(0,0),xytext=(0.39,0.02),fontsize=25)
	

gapdensity()
subplots_adjust(left=None, bottom=None, right=None, top=None, wspace=0.3, hspace=0.3)

grid(False)

plt.savefig('SpecPlot.pdf', bbox_inches='tight')
#show()

