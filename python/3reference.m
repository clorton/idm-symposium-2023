function [X, Xa] = cleanAndNormalizeOpt(X_ref, X_nref)
    % Calculate total read counts for each gene and sample
    totRead = X_ref + X_nref;

    % Initialize X and Xa matrices with default values
    X = repmat(4, size(X_ref));
    Xa = nan(size(X_ref));

    % Set conditions for data cleaning and normalization
    condition1 = totRead >= 5 & X_nref <= 1 & X_ref >= 5;
    condition2 = totRead >= 5 & X_ref <= 1 & X_nref >= 5;
    condition3 = totRead >= 5 & ~condition1 & ~condition2;

    % Apply conditions to update X and Xa matrices
    X(condition1) = 0;
    Xa(condition1) = 0;

    X(condition2) = 1;
    Xa(condition2) = 1;

    X(condition3) = 2;
    Xa(condition3) = X_nref(condition3) ./ totRead(condition3);
end

disp("Loading data...")

load('../data/X_ref.mat');
X_ref = X;
load('../data/X_nref.mat');
X_nref = X;
clear X;

disp("Loaded data. Cleaning data...")

[X, Xa] = cleanAndNormalizeOpt(X_ref, X_nref);

disp("Cleaned data. Saving data...")

% Courtesy of ChatGPT
data = struct('X', X(1:1024,:), 'Xa', Xa(1:1024,:));                    % Create a struct to hold the variables
save('reference.mat', '-struct', 'data', '-v6');    % Save the variables to a .mat file
