#####################################################################
#	VizTool: metabolic network visualisation tool (working version)	#
#####################################################################

The code is licensed under the Creative Commons Attribution license. Please contact the authors if you need any help via miha.moskon@fri.uni-lj.si. 

##############################################################################################################################
# written by Miha Moškon (Computational Biology Group, Faculty of Computer and Information Science, University of Ljubljana) #
# contact: miha.moskon@fri.uni-lj.si																						 #
##############################################################################################################################

Prerequisites:
- Matlab 2015b or newer (requires the implementation of graph function)
- Matlab COBRA Toolbox

Usage:
- Run makePlot.m

Parameters (hardcoded):
- reload_all: prepare the data that are stored in 'mat' files - should be set to 1 at first usage, slows down the execution...
- model_name: name of the mat file with your model
- met_name: name of the metabolite to plot
- dist: maximal distance from selected metabolite
- loc: focus only on this compartment (if loc1 and loc2 are not set)
- loc1, loc2: focus only to the exchange reactions between these compartments
- ignore_fluxes: ignore the fluxes through reactions (should be set to 0)
- minflux: omit all reactions with lower absolute flux than minflux
- reactionTypes: 0 - plot all reactions, 1 - plot reactions producing met_name, -1 - plot reactions consuming met_name
- reversed: plot reversed reaction (negative fluxes) in the opposite direction (should be 1)
- perturbation: assess the perturbations - not supported in this version



