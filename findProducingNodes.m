function [X,Y] = findProducingNodes(S,dist,fluxes,Meta,ignoreFluxes)

    M = length(S(1,:));
    N = length(S(:,1));

    Y = [];
    X = [];
    for d = 1:dist
        RX = [];
        for m = 1:length(Meta)
            for i=1:M %cez vse reakcije
                if (ignoreFluxes ~= 0)
                    if (S(Meta(m),i) > 0) % metabolit nastopa v reakciji kot produkt?
                        Y = [Y,i];
                        for j=1:N % cez vse metabolite
                            if S(j,i) ~= 0 % metabolit nastopa v reakciji
                                X = [X,j];                        
                            end;
                            if (S(j,i) < 0) % metabolit nastopa v reakciji kot reaktant
                               RX = [RX,j];                        
                            end;
                        end;
                    end;    
                else
                    if ((S(Meta(m),i) > 0) && (fluxes(i) >= 0)) || ((S(Meta(m),i) < 0) && (fluxes(i) < 0)) % metabolit nastopa v reakciji kot produkt?
                        Y = [Y,i];
                        for j=1:N % cez vse metabolite
                            if S(j,i) ~= 0 % metabolit nastopa v reakciji
                                X = [X,j];                        
                            end;
                            if ((S(j,i) < 0) && (fluxes(i) >= 0)) || ((S(j,i) > 0) && (fluxes(i) < 0))% metabolit nastopa v reakciji kot reaktant
                               RX = [RX,j];                        
                            end;
                        end;
                    end;    
                end;
            end;   
        end;
        Meta = unique(RX);
    end;

    X = unique(X); % preostali metaboliti
    Y = unique(Y); % preostale reakcije

end

