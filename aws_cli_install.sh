#!/bin/bash

sudo apt remove awscli

sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip -y

sudo unzip awscliv2.zip

sudo ./aws/install

sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo unzip awscliv2.zip

sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo aws --version