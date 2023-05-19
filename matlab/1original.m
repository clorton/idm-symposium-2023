% data from https://www.malariagen.net/parasite/pf3k
load ../data/X_ref.mat;

X_ref = X;

load ../data/X_nref.mat;

X_nref = X;

clear X;

% clean up some of the low counts

% sample index
for patIndex = 1 : length(X_ref(1,:))
    % these are SNP positions, P. falc has 5300 genes, several SNP each
    msg = sprintf( "Processing sample %d of %d", patIndex, length(X_ref(1,:)) )
    disp( msg )
    for geneIndex = 1 : length(X_nref(:,1))
        % cleaning and normalizing read count data
        totRead = X_ref(geneIndex,patIndex) + X_nref(geneIndex,patIndex);
        if totRead < 5
            X(geneIndex,patIndex) = 4;
            Xa(geneIndex,patIndex) = nan;
            %                 Xa(geneIndex,patIndex) = 3;
        elseif (X_nref(geneIndex,patIndex)<=1) && (X_ref(geneIndex,patIndex)>=5)
            X(geneIndex,patIndex) = 0;
            Xa(geneIndex,patIndex) = 0;
        elseif (X_ref(geneIndex,patIndex)<=1) && (X_nref(geneIndex,patIndex)>=5)
            X(geneIndex,patIndex) = 1;
            Xa(geneIndex,patIndex) = 1;
        else
            X(geneIndex,patIndex) = 2;
            Xa(geneIndex,patIndex) = X_nref(geneIndex,patIndex)/totRead;
        end
    end
end
