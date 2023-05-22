#! /usr/bin/env python3

import numpy as np

"""
Write the code to extract variable "X" from a MATLAB .mat file using Python and
the scipy package.
"""
"""
Certainly! Here's an example code snippet that demonstrates how to extract the
variable "X" from a MATLAB .mat file using Python and the scipy package:
"""
"""
import scipy.io

# Load the MATLAB .mat file
mat_data = scipy.io.loadmat('your_file.mat')

# Extract the variable 'X'
X = mat_data['X']
"""

# Use suggest code to load the .mat files.
# Also remove _copy suffix on arrays.
import scipy.io

X_ref = scipy.io.loadmat('../data/X_ref.mat')['X']
X_nref = scipy.io.loadmat('../data/X_nref.mat')['X']

# Clean up some of the low counts

# Calculate total read counts for each gene and sample
totRead = X_ref + X_nref

# Initialize X and Xa arrays with default values
X = np.full_like(X_ref, 4)
Xa = np.empty_like(X_ref)
Xa[:] = np.nan

# Set conditions for data cleaning and normalization
condition1 = np.logical_and.reduce((totRead >= 5, X_nref <= 1, X_ref >= 5))
condition2 = np.logical_and.reduce((totRead >= 5, X_ref <= 1, X_nref >= 5))
condition3 = np.logical_not(np.logical_or(condition1, condition2))

# Apply conditions to update X and Xa arrays
X[condition1] = 0
Xa[condition1] = 0

X[condition2] = 1
Xa[condition2] = 1

X[condition3] = 2
Xa[condition3] = X_nref[condition3] / totRead[condition3]
