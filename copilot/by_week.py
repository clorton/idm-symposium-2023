#! /usr/bin/env python3

# Create a variable SCRIPT_DIR with the absolute path to the directory containing this script using Path from the pathlib package
from pathlib import Path
SCRIPT_DIR = Path(__file__).parent.absolute()

# load the data from the file "WHO_NREVSS_Clinical_Labs.csv" using Pandas, skipping the first line
import pandas as pd
df = pd.read_csv(SCRIPT_DIR.parent / "data" / "WHO_NREVSS_Clinical_Labs.csv", skiprows=1)

# aggregate the columns "TOTAL A" and "TOTAL B" into a new column "TOTAL"
df["TOTAL"] = df["TOTAL A"] + df["TOTAL B"]

# calculate the mean and variance of the column "TOTAL" by WEEK
df_by_week = df.groupby("WEEK").agg({"TOTAL": ["mean", "var"]})

# use matplot lib to plot the mean and variance by week
import matplotlib.pyplot as plt
plt.plot(df_by_week["TOTAL"]["mean"], label="mean")
# plt.plot(df_by_week["TOTAL"]["var"], label="variance")
plt.legend()

# save the plot to a .PNG file in SCRIPT_DIR
plt.savefig(SCRIPT_DIR / "by_week.png")
