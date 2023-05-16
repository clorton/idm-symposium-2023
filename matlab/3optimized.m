%{
User: Please optimize the for loop in the previous code.
ChatGPT: To optimize the for loop in the previous code, you can use vectorization techniques instead of nested loops. Here's an optimized version of the code:
%}

function [X, Xa] = cleanAndNormalizeOpt(X_ref, X_nref)
    % Calculate total read counts for each gene and sample
    totRead = X_ref + X_nref;

    % Initialize X and Xa matrices with default values
    X = repmat(4, size(X_ref));
    Xa = nan(size(X_ref));

    % Set conditions for data cleaning and normalization
    condition1 = totRead >= 5 & X_nref <= 1 & X_ref >= 5;
    condition2 = totRead >= 5 & X_ref <= 1 & X_nref >= 5;
    condition3 = ~condition1 & ~condition2;     # Note, this is a bug, need to check for totRead >= 5

    % Apply conditions to update X and Xa matrices
    X(condition1) = 0;
    Xa(condition1) = 0;

    X(condition2) = 1;
    Xa(condition2) = 1;

    X(condition3) = 2;
    Xa(condition3) = X_nref(condition3) ./ totRead(condition3);
end

%{
ChatGPT: By utilizing element-wise operations and logical indexing, the optimized code avoids the need for explicit nested loops. Instead, it performs calculations on entire matrices at once, resulting in improved efficiency and faster execution.
%}