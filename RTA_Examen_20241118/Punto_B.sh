#!/bin/bash

# Crear grupos
groupadd -f grupo1
groupadd -f grupo2
groupadd -f grupo3

# Crear usuarios y asignarlos a grupos
if ! id -u usuario1 &>/dev/null; then
    useradd -m -p $(openssl passwd -6 'contraseña_segura1') usuario1
    usermod -aG grupo1 usuario1
    echo "usuario1:grupo1" >> Lista_Usuarios.txt
fi

if ! id -u usuario2 &>/dev/null; then
    useradd -m -p $(openssl passwd -6 'contraseña_segura2') usuario2
    usermod -aG grupo2 usuario2
    echo "usuario2:grupo2" >> Lista_Usuarios.txt
fi

if ! id -u usuario3 &>/dev/null; then
    useradd -m -p $(openssl passwd -6 'contraseña_segura3') usuario3
    usermod -aG grupo3 usuario3
    echo "usuario3:grupo3" >> Lista_Usuarios.txt
fi
