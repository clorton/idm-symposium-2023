function [X, Xa] = cleanAndNormalizeOG(X_ref, X_nref)
    [numGenes, numSamples] = size(X_ref);
    X = zeros(numGenes, numSamples);
    Xa = NaN(numGenes, numSamples);

    for patIndex = 1 : numSamples
        % msg = sprintf("Processing sample %d ", patIndex);
        % disp(msg);

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

function [X, Xa] = cleanAndNormalizeOpt(X_ref, X_nref)
    % Calculate total read counts for each gene and sample
    totRead = X_ref + X_nref;

    % Initialize X and Xa matrices with default values
    X = repmat(4, size(X_ref));
    Xa = nan(size(X_ref));

    % Set conditions for data cleaning and normalization
    condition1 = totRead >= 5 & X_nref <= 1 & X_ref >= 5;
    condition2 = totRead >= 5 & X_ref <= 1 & X_nref >= 5;
    condition3 = ~condition1 & ~condition2;

    % Apply conditions to update X and Xa matrices
    X(condition1) = 0;
    Xa(condition1) = 0;

    X(condition2) = 1;
    Xa(condition2) = 1;

    X(condition3) = 2;
    Xa(condition3) = X_nref(condition3) ./ totRead(condition3);
end

%{
User: Write a test function to load data/X_ref.mat into a variable X_ref and data/X_nref.mat into a variable X_nref and then compare the results of calling the function cleanAndNormalizeA() and the function cleanAndNormalizeB() with X_ref and X_nref.
ChatGPT: Certainly! Here's a test function that loads the data, calls both versions of the cleanAndNormalize function, and compares the results:
User: Modify the test function to only process the first 50 rows of X_ref and X_nref.
ChatGPT: Here's the modified test function that processes only the first 50 rows of X_ref and X_nref matrices:
%}

% compare functions using the first 50 rows of X_ref and X_nref
function testCleanAndNormalize()
    disp("Testing output of functions on first 50 rows...")
    % Load data/X_ref.mat and data/X_nref.mat
    load('../data/X_ref.mat');
    X_ref = X(1:50,:);
    load('../data/X_nref.mat');
    X_nref = X(1:50,:);

    % Call cleanAndNormalizeOG and cleanAndNormalizeOpt
    [Xa_A, Xa_Aa] = cleanAndNormalizeOG(X_ref, X_nref);
    [Xa_B, Xa_Ba] = cleanAndNormalizeOpt(X_ref, X_nref);

    % Compare the results
    areEqual_Xa = isequal(Xa_A, Xa_B);
    areEqual_Xa = isequal(Xa_Aa, Xa_Ba);    % Note, this is two bugs...
    % We are overwriting the first result into the same variable and
    % should use isequaln() because we consider NaNs equivalent.

    if areEqual_Xa && areEqual_Xa
        disp('Both versions of cleanAndNormalize produce the same results.');
    else
        disp('There is a difference between the results of cleanAndNormalizeOG and cleanAndNormalizeOpt.');
    end
end

%{
ChatGPT: In this modified version, after loading X_ref and X_nref matrices, only the first 50 rows of each matrix are selected using indexing (X(1:50, :)). Then, the selected matrices are passed to both versions of the cleanAndNormalize function. The comparison and display logic remains the same as before.
%}

testCleanAndNormalize()

% time 50 rows in cleanAndNormalizeOG

% Load data/X_ref.mat and data/X_nref.mat
load('../data/X_ref.mat');
X_ref = X;
load('../data/X_nref.mat');
X_nref = X;

disp("Cleaning 50 rows with original code...");

tic;                % Start the timer
% Call cleanAndNormalize function on the first 50 rows
[X, Xa] = cleanAndNormalizeOG(X_ref(1:50,:), X_nref(1:50,:));
elapsedTime = toc;  % Stop the timer and calculate the elapsed time

% Display the elapsed time
disp(['Elapsed time: ' num2str(elapsedTime) ' seconds']);

% time _all_ rows in cleanAndNormalizeOpt
[numGenes, numSamples] = size(X_ref);
disp(sprintf("Cleaning %d rows with optimized code...", numSamples));
tic;
[X, Xa] = cleanAndNormalizeOpt(X_ref, X_nref);
elapsedTime = toc;
disp(['Elapsed time: ' num2str(elapsedTime) ' seconds']);
