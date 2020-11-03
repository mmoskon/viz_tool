function [s,t,w] = makePairsReversed(S, fluxes)

M = length(S(1,:));
N = length(S(:,1));


num_edges = nnz(S);

s = zeros(1,num_edges); % sources
t = zeros(1,num_edges); % targets
w = zeros(1,num_edges); % weights

idx = 1;
for i = 1 : M
   for j = 1 : N
        % id reakcije = i
        % id metabolita = M + j    
        if ((S(j,i) > 0) && (fluxes(i) >= 0)) || ((S(j,i) < 0) && (fluxes(i) < 0)) % product
            s(idx) = i;
            t(idx) = M + j;
            w(idx) = abs(fluxes(i));
            idx = idx + 1;
         elseif ((S(j,i) < 0) && (fluxes(i) >= 0)) || ((S(j,i) > 0) && (fluxes(i) < 0)) % reactant
            s(idx) = M + j;
            t(idx) = i;
            w(idx) = abs(fluxes(i));
            idx = idx + 1;
       end;
    end;
end;

s = s(s~=0);
t = t(t~=0);
w = w(1:length(s));

end

