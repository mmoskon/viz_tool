function runFBA(model_name)

    %load('model.mat');
    load(model_name);
    %initCobraToolbox();

    %model1 = changeObjective(model,'ASNS1',1) 
    %model1 = changeObjective(model,'biomass_cho',1) 
    model1 = changeObjective(model,'biomass_cho_producing',1) 

    solution = optimizeCbModel(model1);

    save('FBAsolution.mat','solution')
end
