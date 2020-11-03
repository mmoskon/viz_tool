% pomeci stran reakcije, ki imajo prevec reaktantov/produktov
function S = limitReactions(S, max_products, max_reactants)

    M = length(S(1,:));

    X = S;
    X(X<0) = 0;
    Y = S;
    Y(Y>0) = 0;
    Y=abs(Y);

    % dodano
    X(X>0) = 1;
    Y(Y>0) = 1;
    
    for i = 1:M
       if (sum(X(:,i))>=max_products)||(sum(Y(:,i))>=max_reactants)
           S(:,i) = 0;
       end;
    end;
  

end

