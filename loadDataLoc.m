function data = loadDataLoc(loc, loc1, loc2, model_name)
    
  
    file_name = '';
    if (loc1 ~= 0) && (loc2 ~= 0)
        file_name  = 'data_ce';       
    elseif (loc==0)
        file_name = 'data_all';
    elseif (loc==1)
        file_name = 'data_cytosol';
    elseif(loc==3)
        file_name = 'data_external';
    end;

    file_name = strcat(file_name,'_',model_name,'.mat');
    load(file_name);
end

