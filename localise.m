%load('model.mat');
load('iCHOv1_gimme_final.mat');
model = gimmeS;
model = gimmeDG44;

S = model.S;
mets = model.mets;

reacts = model.rxnNames;

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


mets_loc = zeros(length(mets),1);
for i=1:length(mets)
   loc_id = char(mets(i));
   id=strsplit(loc_id,']');
   id=char(id(1));
   id=strsplit(id,'[');
   id=char(id(2));
   
   switch id
       case 'c'
           loc = 1;
       case 'r'
           loc = 2;
       case 'e'
           loc = 3;
       case 'g'
           loc = 4;
       case 'x'
           loc = 5;
       case 'im'
           loc = 6;           
       case 'm'
           loc = 7;
       case 'l'
           loc = 8;
       case 'n'
           loc = 9;
       otherwise      
           loc = 1;
   end;
     
   mets_loc(i,1) = loc;
   
end;

%save('mets_loc_S.mat','mets_loc');
save('mets_loc_DG44.mat','mets_loc');