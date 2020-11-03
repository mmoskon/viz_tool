function S = limitCompartments(S, loc, model_name )



    % omeji se na citoplazmo
    % clean 0
    
    %load('mets_loc.mat');
    
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

    if (loc ~= 0)
        for i=1:M
            for j=1:N
                if (S(j,i)~=0)
                    if (mets_loc(j)~=loc)  % ce reakcija ne poteka v celoti v compartmentu
                        S(:,i) = 0;
                        break;
                    end;
                end;
            end;
        end;

        S(mets_loc~=loc,:)=0;
    end;


end

