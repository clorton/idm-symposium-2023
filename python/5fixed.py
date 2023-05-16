#! /usr/bin/env python3

from pathlib import Path

import numpy as np
import scipy.io

SCRIPT_DIR = Path(__file__).parent.absolute()

print("Loading X_ref and X_nref...")
X_ref = scipy.io.loadmat(SCRIPT_DIR.parent / 'data' / 'X_ref.mat')['X']
X_nref = scipy.io.loadmat(SCRIPT_DIR.parent / 'data' / 'X_nref.mat')['X']

print("Cleaning data...")
# Clean up some of the low counts

# Calculate total read counts for each gene and sample
totRead = X_ref + X_nref

# Initialize X and Xa arrays with default values
X = np.full_like(X_ref, 4)
Xa = np.empty_like(X_ref, dtype=np.float32)     # fixed
Xa[:] = np.nan

# Set conditions for data cleaning and normalization
condition1 = np.logical_and.reduce((totRead >= 5, X_nref <= 1, X_ref >= 5))
condition2 = np.logical_and.reduce((totRead >= 5, X_ref <= 1, X_nref >= 5))
# condition3 = np.logical_not(np.logical_or(condition1, condition2))
condition3 = (totRead >= 5) & np.logical_not(np.logical_or(condition1, condition2))

# Apply conditions to update X and Xa arrays
X[condition1] = 0
Xa[condition1] = 0

X[condition2] = 1
Xa[condition2] = 1

X[condition3] = 2
Xa[condition3] = X_nref[condition3] / totRead[condition3]

# Load reference data from MATLAB/Octave
print("Loading reference data...")
reference = scipy.io.loadmat(SCRIPT_DIR / 'reference.mat')
X_test = reference['X']
Xa_test = reference['Xa']

print("Comparing output and reference...")
rows = X_test.shape[0]
assert np.array_equal(X[:rows,:], X_test), "X and X_test are NOT equal."
assert np.allclose(Xa[:rows,:], Xa_test, equal_nan=True), "Xa and Xa_test are NOT equal."
print("Output and reference are same.")
