#!/bin/bash
# Update apt
sudo apt-get update -y
# Install git
sudo apt-get install git -y

# Install pip3
sudo apt-get install python3-pip -y
# Set python3.10 as default
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
# Install NPM
# Go to repository
cd ../Backend
# Install requirements
pip3 install -r requirements.txt
# Resolve JWT error
pip uninstall JWT -y
pip uninstall PyJWT -y
pip install PyJWT
# Start python3 backend server
nohup python3 main.py &

