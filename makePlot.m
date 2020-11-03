dist = 1;
reload_all = 1;


loc = 0;
loc1 = 0;
loc2 = 0;
ignore_fluxes = 0;
minflux = 0.0001;
reactionTypes = 0; 
reversed = 1;

model_name = 'model.mat';

met_name = 'asn_L[c]'; 

perturbation = 0;

plotBipartite(reload_all, loc, loc1, loc2, met_name, dist, reactionTypes, ignore_fluxes, minflux, reversed, perturbation, model_name)