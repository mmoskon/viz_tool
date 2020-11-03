function plotBipartiteComparison(reload_all, loc, loc1, loc2, met_name, dist, reactionTypes, ignore_fluxes, minflux, reversed, comparisonType, model_name)

%ignore_fluxes = 0;
%minflux = 0.01; % minimal flux to output a reaction
%reactionTypes = 0; % 0..all reactions, 1..producers, -1..consumers

% compartment exchange
%loc1 = 1;
%loc2 = 3;
%loc1 = 0;
%loc2 = 0;

% one compartment - if 0 no limit, cytosol = 1, e = 3
%loc = 0; 

% max distance from metabolite 
%dist = 1;
% select a metabolite
%met_name = 'asn_L[c]'; 
%met_name = 'asn_L[e]';
%met_name = 'asp_L[c]'; 
%met_name = 'gln_L[c]'; 
%met_name = 'glu_L[c]'; 
%met_name = 'pyr[c]'; 
%met_name = 'akg[c]'; 
%met_name = 'HC00591[c]'; 
%met_name = 'Nacasp[c]'; 
%met_name = 'nh4[c]'; 
%met_name = 'CE1556[c]'; 


num_plot = 2;

%model = readCbModel('iCHOv1_final.xml')
%save('model.mat',model)

if reload_all

    %load('model.mat');
    %load('model_S.mat');
    load('iCHOv1_gimme_final.mat');
    if strcmp(model_name, 'S')
        model = gimmeS;
    elseif strcmp(model_name, 'DG44')
        model = gimmeDG44;
    end;
    
    S = model.S;
    M = length(S(1,:));
    N = length(S(:,1));
    mets = model.mets;
    reacts = model.rxns;
    metNames = model.metNames;
    rxnNames = model.rxnNames;

    if (loc1 ~= 0) && (loc2 ~= 0)
        S = limitCompartmentsExchange(S, loc1, loc2, model_name);
    elseif (loc ~= 0)
        S = limitCompartments(S, loc, model_name);
    end;
    
    % pomeci stran reakcije, ki imajo prevec reaktantov/produktov
    max_products = 25;
    max_reactants = 25;
    S = limitReactions(S, max_products, max_reactants);

   
    
    % pomeci stran vse zelo pogoste metabolite
    max_products = 1000;
    max_reactants = 1000;
    S = limitMetabolites(S, max_products, max_reactants);
    
    % SAVE DATA
    saveDataLoc(S, mets, reacts, metNames, rxnNames, loc, loc1, loc2, model_name);
   
else
    % LOAD DATA
    data=loadDataLoc(loc, loc1, loc2, model_name);
    
    S = data.S;
    mets = data.mets;
    reacts = data.reacts;
    metNames = data.metNames;
    rxnNames = data.rxnNames;

end; %end if reload_all


    
% poisci indeks metabolita
Meta = find(strcmp(mets,met_name));
full_name = metNames(Meta);

% FBA
%load('FBAsolution.mat');

if strcmp(model_name, 'S')
    load('FBA_hooman_S_non_perturbed.mat');
    fluxes1 = solution.x;
    load('FBA_hooman_S_perturbed.mat')
    fluxes2 = solution.x;
elseif strcmp(model_name, 'DG44')
    load('FBA_hooman_DG44_non_perturbed.mat');
    fluxes1 = solution.x;
    load('FBA_hooman_DG44_perturbed.mat')
    fluxes2 = solution.x;    
end;



if comparisonType == 1
    % samo reakcije, ki so se pojavile na novo
    %fluxes1(fluxes2 == 0) = 0;
    %fluxes = fluxes2 - fluxes1;
    
    fluxes2(fluxes1 ~= 0) = 0;
    fluxes = fluxes2;
elseif comparisonType == -1
    % samo reakcije, ki so izginile
    %fluxes2(fluxes1 == 0) = 0;
    %fluxes = fluxes1 - fluxes2;
    fluxes1(fluxes2 ~= 0) = 0;
    fluxes = fluxes1;
else
    % samo reakcije, ki so aktivne v obeh primerih
    fluxes1(fluxes2 == 0) = 0;
    fluxes2(fluxes1 == 0) = 0;
    fluxes = fluxes2;
end;

%fluxes(findRxnIDs(model,'EX_asn_L_e_'))


% izlocanje reakcij, ki so absolutno pod mejo pretoka
if (ignore_fluxes == 0)
    if (minflux ~= 0) 
        S(:,abs(fluxes)<minflux)=0;
    end;
end;
% end of FBA

%%%%%%%%%%%%%%%%%%%%
%%%% glavni del %%%%
%%%%%%%%%%%%%%%%%%%%
if (reactionTypes == 0)
    % najdi vse povezane
    [X,Y] = findConnectedNodes(S,dist,Meta);
elseif (reactionTypes == 1)
    % najdi producerje
    [X,Y] = findProducingNodes(S,dist,fluxes,Meta, ignore_fluxes);
elseif (reactionTypes == -1)
    % najdi porabnike
    [X,Y] = findConsumingNodes(S,dist,fluxes,Meta, ignore_fluxes);
end;

% iskanje najkrajsih poti
% ...



% RESIZE EVERYTHING
S = S(X,:);
S = S(:,Y);
if isempty(fluxes)
    fluxes = zeros(1,length(Y));
else
    fluxes = fluxes(Y);
end
mets = mets(X);
reacts = reacts(Y);
metNames = metNames(X);
rxnNames = rxnNames(Y);
M = length(S(1,:));
N = length(S(:,1));
% END OF RESIZE





% naredi graf
if (reversed == 1) && (ignore_fluxes == 0)
    % reversed reactions not ignored, marked
    [s,t,w] = makePairsReversed(S, fluxes); 
    %reacts_fluxes = strcat(reacts,': ',num2str(abs(solution.x(Y))));
    reacts_fluxes = strcat(reacts,': ',num2str(abs(fluxes)));
    reacts_fluxes(fluxes<0) =  strcat(reacts_fluxes(fluxes<0),'; REV');      
else
    % reversed reactions ignored,
    [s,t,w] = makePairs(S, fluxes); 
    if ignore_fluxes == 0
        %reacts_fluxes = strcat(reacts,': ',num2str(solution.x(Y)));  
        reacts_fluxes = strcat(reacts,': ',num2str(fluxes));  
    end
end 



% coloring of the neighboring nodes
my_met = find(strcmp(mets,met_name));
producers = s(find(t==M+my_met));
consumers = t(find(s==M+my_met));

%reversed = unique(reversed);
%reacts_fluxes(reversed) = strcat(reacts_fluxes(reversed),'; REV');
%reacts = blanks(length(reacts));

%names={'r1','r2','m1','m2','m3'};
G = digraph(s,t,w);
%g = plot(G,'NodeLabel',[reacts,mets],'Layout','force');
fig = figure(num_plot);
clf
title(strcat(met_name,': ',full_name));
hold on
% widths denote the fluxes
if ignore_fluxes == 0
    max_flux = max(100,max(abs(G.Edges.Weight)));
    min_width = 0.001;
    l_width = max(min_width,2 * abs(G.Edges.Weight/max_flux));

    %g = plot(G,'LineWidth',l_width,'NodeLabel',[reacts_fluxes;mets],'Layout','layered','EdgeLabel',G.Edges.Weight);
    g = plot(G,'LineWidth',l_width,'NodeLabel',[reacts_fluxes;mets],'Layout','layered');
    %g = plot(G,'Layout','force');
else
    g = plot(G,'NodeLabel',[reacts;mets],'Layout','layered');
end;
set(gca,'box','off')
highlight(g,1:M);
highlight(g,1:M,'NodeColor','magenta');
highlight(g,producers,'NodeColor','green');
highlight(g,consumers,'NodeColor','red');
axis off
hold off
fig.Position=[0,0,1000,600];
print('-bestfit',strcat('img/',met_name),'-dpdf')
%print(strcat('img/',met_name),'-dpng')
print('_fig','-dpng')

fileID = fopen(strcat('img/',met_name,'.txt'),'w');
fprintf(fileID,'*******************\n');
fprintf(fileID,'*** METABOLITES ***\n');
fprintf(fileID,'*******************\n');
for i=1:length(mets)
    fprintf(fileID,'%s: %s\n',strjoin(mets(i)),strjoin(metNames(i)));
end;

fprintf(fileID,'\n');
fprintf(fileID,'******************\n');
fprintf(fileID,'*** REACTIONS ***\n');
fprintf(fileID,'******************\n');
for i=1:length(reacts)
    fprintf(fileID,'%s: %s\n',strjoin(reacts(i)),strjoin(rxnNames(i)));
end;
fclose(fileID);

end
