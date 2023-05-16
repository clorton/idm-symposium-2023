%{
User: Given the following MATLAB code, extract the two loops into a function taking two input matrices and returns two output matrices.
ChatGPT: You can use this function by passing the X_ref and X_nref matrices as input, and it will return the updated X and Xa matrices as output.
%}

function [X, Xa] = cleanAndNormalizeOG(X_ref, X_nref)
    [numGenes, numSamples] = size(X_ref);
    X = zeros(numGenes, numSamples);
    Xa = NaN(numGenes, numSamples);

    for patIndex = 1 : numSamples
        msg = sprintf("Processing sample %d ", patIndex);
        disp(msg);

        for geneIndex = 1 : numGenes
            totRead = X_ref(geneIndex, patIndex) + X_nref(geneIndex, patIndex);
            X(geneIndex, patIndex) = 4;
            Xa(geneIndex, patIndex) = NaN;

            if totRead >= 5
                if X_nref(geneIndex, patIndex) <= 1 && X_ref(geneIndex, patIndex) >= 5
                    X(geneIndex, patIndex) = 0;
                    Xa(geneIndex, patIndex) = 0;
                elseif X_ref(geneIndex, patIndex) <= 1 && X_nref(geneIndex, patIndex) >= 5
                    X(geneIndex, patIndex) = 1;
                    Xa(geneIndex, patIndex) = 1;
                else
                    X(geneIndex, patIndex) = 2;
                    Xa(geneIndex, patIndex) = X_nref(geneIndex, patIndex) / totRead;
                end
            end
        end
    end
end
