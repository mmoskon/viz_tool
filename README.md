#	VizTool: genome-scale metabolic network visualisation tool

## About
* This code is supplementing the paper [Computational modelling of genome-scale metabolic networks and its application to CHO cell cultures](https://www.sciencedirect.com/science/article/abs/pii/S0010482517302299) ([preprint](https://www.researchgate.net/publication/318302646_Computational_modelling_of_genome-scale_metabolic_networks_and_its_application_to_CHO_cell_cultures))
* Written by Miha Moškon (Computational Biology Group, Faculty of Computer and Information Science, University of Ljubljana)
* contact: [miha.moskon@fri.uni-lj.si](mailto:miha.moskon@fri.uni-lj.si)

This code was latter ported to Python and extended with additional functionalities and a graphical user interface. These extensions are available in the [Grohar repository](https://github.com/mmoskon/Grohar) and described in the paper [Grohar: Automated Visualization of Genome-Scale Metabolic Models and Their Pathways](https://www.liebertpub.com/doi/abs/10.1089/cmb.2017.0209) ([preprint](https://www.researchgate.net/publication/323297141_Grohar_Automated_Visualization_of_Genome-Scale_Metabolic_Models_and_Their_Pathways))

## Prerequisites:
* Matlab 2015b or newer (requires the implementation of graph function)
* Matlab COBRA Toolbox

## Usage:

Run makePlot.m

### Parameters (hardcoded):
* `reload_all`: prepare the data that are stored in `mat` files - should be set to `1` at first usage, slows down the execution...
* `model_name`: name of the `mat` file with your model
* `met_name`: name of the metabolite to plot
* `dist`: maximal plotting distance from selected metabolite
* `loc`: focus only on this compartment (if `loc1` and `loc2` are not set)
* `loc1`, `loc2`: focus only to the exchange reactions between these compartments
* `ignore_fluxes`: ignore the fluxes through reactions (should be set to 0)
* `minflux`: omit all reactions with lower absolute flux than `minflux`
* `reactionTypes`: `0` - plot all reactions, `1` - plot reactions producing `met_name`, `-1` - plot reactions consuming `met_name`
* `reversed`: plot reversed reaction (negative fluxes) in the opposite direction (should be `1`)
* `perturbation`: assess the perturbations - not supported in this version

## How to cite this code
If you are using this code for your scientific work please cite the papers:

* Rejc, Živa, et al. "Computational modelling of genome-scale metabolic networks and its application to CHO cell cultures." Computers in biology and medicine 88 (2017): 150-160.
* Moškon, Miha, Nikolaj Zimic, and Miha Mraz. "Grohar: Automated Visualization of Genome-Scale Metabolic Models and Their Pathways." Journal of Computational Biology 25.5 (2018): 505-508.






