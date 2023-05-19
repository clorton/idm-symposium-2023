# <p style="text-align: center;">AI Assisted Coding - IDM Spring 2023 Symposium</p>

## Setup

1) Make sure you have an account with [ChatGPT](https://openai.com/product/chatgpt) ($0)
2) Login to or sign up for a [GitHub](https://github.com) account ($0)
3) Create a fork of the [breakout session materials repository](https://github.com/clorton/idm-symposium-2023)<br>![fork](/media/fork.png)
4) Start up a [codespace](https://github.com/codespaces) for editing and running the code<br>![codespace](/media/codespace.png)<br>Select your fork of the session repository<br>![repository](/media/repository.png)<br>Bump system specs to 4-core 8GB RAM<br>![machine](/media/machine.png)

-----

# <p style="text-align: center;">Activities</p>

## Explain, Refactor, Optimize, and Test MATLAB Code (`matlab` folder)

1. original
2. refactored into function
3. optimized with vector operations
4. tested
5. fixed

## Translate MATLAB Code to Python (`python` folder)

1. translated
2. load from `.mat` files
3. create reference data
4. test translation
5. fix translation

## Live Coding with Copilot/ChatGPT (`copilot` folder)

1. load `.csv` file
2. aggregate case counts for type A and type B
3. calculate mean and variance
4. implement test
5. run test on reference data
6. calculate mean by week
7. plot with `matplotlib`
8. save to `.png` file

## SEIR Model with Copilot (`model` folder)

1. import numpy and matplotlib.pyplot
2. prompt for function to run model
3. prompt for function invoke model and plot results

-----

# <p style="text-align: center;">Resources</p>

### Example Code Repository

This repository [clorton/idm-symposium-2023](https://github.com/clorton/idm-symposium-2023)

### Octave in GitHub Codespace

Takes about 5 minutes to install. Note that there is a prompt you must respond to about ½ way through the installation.

```bash
sudo apt update
sudo apt-get install -y octave
```

### Install R in GitHub Codespace

Takes about 5 minutes to install.

[instructions](https://cran.rstudio.com/bin/linux/ubuntu)

```bash
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base
```

Additional steps for integration with GitHub Codespace:

```bash
sudo /usr/bin/R --silent --slave --no-save --no-restore -e "install.packages('languageserver', repos='https://cloud.r-project.org/')"
sudo /usr/bin/R --silent --slave --no-save --no-restore -e "install.packages('jsonlite')"
```

### GitHub Codespaces

[overview](https://docs.github.com/en/codespaces/overview)
