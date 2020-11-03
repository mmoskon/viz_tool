% iskanje reakcij, ki jih bomo izrisali!
function [X,Y] = findConnectedNodes(S,dist,Meta)
   
    M = length(S(1,:));
    N = length(S(:,1));
   
    Y = [];
    for d = 1:dist
        X = [];
        for m = 1:length(Meta)
            for i=1:M %cez vse reakcije
                if S(Meta(m),i) ~= 0 % metabolit nastopa v reakciji?
                    Y = [Y,i];
                    for j=1:N % cez vse metabolite
                        if S(j,i) ~= 0 % metabolit nastopa v reakciji
                            X = [X,j];
                        end;
                    end;
                end;    
            end;   
        end;
        Meta = unique(X);
    end;

    X = Meta; % preostali metaboliti
    Y = unique(Y); % preostale reakcije



end

