#desde la carpeta de 202406/docker

sudo apt update
sudo apt install nginx

#iniciar nginx

sudo systemctl start nginx
sudo systemctl enable nginx

#agregar vagrant al grupo Docker

sudo usermod -a -G docker vagrant
