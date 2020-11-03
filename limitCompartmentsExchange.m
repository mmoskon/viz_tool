function S = limitCompartmentsExchange(S, loc1, loc2, model_name)



    % omeji se na citoplazmo
    % clean 0
    
    %load('mets_loc.mat');
    %load('mets_loc_S.mat');
    
    if strcmp(model_name, 'S')
        load('mets_loc_S.mat');
    elseif strcmp(model_name, 'DG44')
        load('mets_loc_DG44.mat');
    end;
    
    % COMPARTMENTS
    % c=cytosol (1)
    % r=endoplasmic reticulum (2)
    % e=extracellular space (3)
    % g=golgi apparatus (4)
    % x=peroxisome (5)
    % im=intermembrane space of the mitochondria (6)
    % m=mitochondria (7)
    % l=lysosome (8)
    % n=nucleus (9)
   
    
    M = length(S(1,:));
    N = length(S(:,1));
    
    if (loc1 ~= 0) && (loc2 ~= 0)
        for i=1:M
            
            found1 = false;
            found2 = false;
    
            for j=1:N
                if (S(j,i)~=0)
                    if (mets_loc(j)~=loc1) && (mets_loc(j)~=loc2)  % samo dva kompartmenta
                        S(:,i) = 0;
                        break;                        
                    end;
                    if (mets_loc(j)==loc1)
                        found1 = true;
                    elseif (mets_loc(j)==loc2)
                        found2 = true;
                    end;
                end;                
            end;
            if ~found1 || ~found2
                S(:,i) = 0;
            end;
        end;

        S((mets_loc~=loc1) & (mets_loc~=loc2),:)=0;
    end;


end

