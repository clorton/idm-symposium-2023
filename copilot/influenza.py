#! /usr/bin/env python3

# Create a variable SCRIPT_DIR with the absolute path to the directory containing this script using Path from the pathlib package
from pathlib import Path
SCRIPT_DIR = Path(__file__).parent.absolute()

import pandas as pd

# define a function to read data from the given file and return the mean and variance of the column "TOTAL"
def get_mean_and_variance(filename):
    """Read data from the given file and return the mean and variance of the column "TOTAL""""
    # load data from filename using Pandas, skipping the first line
    df = pd.read_csv(filename, skiprows=1)

    # aggregate the columns "TOTAL A" and "TOTAL B" into a new column "TOTAL"
    df["TOTAL"] = df["TOTAL A"] + df["TOTAL B"]

    # calculate the mean and variance of the column "TOTAL"
    mean = df["TOTAL"].mean()
    variance = df["TOTAL"].var(ddof=0)

    # return the mean and variance
    return mean, variance

# Get the mean and variance for the file "WHO_NREVSS_Clinical_Labs.csv" in the data directory above this one
m, v = get_mean_and_variance(SCRIPT_DIR.parent / "data" / "WHO_NREVSS_Clinical_Labs.csv")

# print the mean and variance
print("Mean: " + str(m))
print("Variance: " + str(v))

# write a function to test get_mean_and_variance with the file reference.csv and the expected mean and variance
def test_get_mean_and_variance():
    """Test get_mean_and_variance with the file test_case.csv and the expected mean and variance"""
    m, v = get_mean_and_variance(SCRIPT_DIR / "test_case.csv")
    assert m == 5, f"{m=}"
    assert v == 11, f"{v=}"
    print("Test passed.")

# call the test function
test_get_mean_and_variance()
