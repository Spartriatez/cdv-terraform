#!/bin/bash
# Update apt
sudo apt-get update -y
# Install git
sudo apt-get install git -y

sudo apt-get install python3-pip -y
# Set python3.10 as default
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
# Install nginx
sudo apt-get install nginx -y
# Enable nginx
sudo systemctl enable nginx
# Start nginx
sudo systemctl start nginx
# Update OpenSSL
sudo apt-get upgrade openssl

sudo apt-get install npm -y
# Install NodeJS
sudo apt-get install nodejs -y
# install React
sudo npm install -g create-react-app

cd ~/

git clone https://github.com/Spartriatez/cdv-terraform.git
# Go to repository
cd ../Frontend
# Install requirements
npm install
# Build react
npm run build
# Copy build to nginx
sudo cp -r build/* /var/www/html/

# Copy nginx config
sudo cp ../Infra/nginx.conf /etc/nginx/sites-available/default
# Restart nginx
sudo systemctl restart nginx

