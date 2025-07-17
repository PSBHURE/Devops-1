#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enavle nginx

echo "<h1>Your NGINX is installed</h1>" | sudo tee /var/www/html/index.html
 