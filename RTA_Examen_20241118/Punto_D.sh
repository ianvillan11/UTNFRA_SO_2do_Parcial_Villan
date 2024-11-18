#!/bin/bash

# Crear estructura de directorios
echo "Creando estructura de directorios..."
mkdir -p /tmp/2do_parcial/alumno
mkdir -p /tmp/2do_parcial/equipo

# Generar datos del alumno
echo "Generando datos del alumno..."
cat <<EOF > /tmp/2do_parcial/alumno/datos_alumno.txt
Nombre: Depaolo, Juan Manuel
Division: 113
EOF

# Obtener información del sistema
echo "Obteniendo información del sistema..."
IP=$(hostname -I | awk '{print $1}')
DISTRO=$(lsb_release -d | cut -f2)
CORES=$(nproc)

# Generar datos del equipo
echo "Generando datos del equipo..."
cat <<EOF > /tmp/2do_parcial/equipo/datos_equipo.txt
Ip: $IP
Distribucion: $DISTRO
Cantidad de cores: $CORES
EOF

# Crear el grupo 2PSupervisores si no existe
echo "Comprobando si el grupo 2PSupervisores existe..."
if ! getent group 2PSupervisores > /dev/null; then
    echo "Creando el grupo 2PSupervisores..."
    sudo groupadd 2PSupervisores
else
    echo "El grupo 2PSupervisores ya existe."
fi

# Configurar sudoers para el grupo 2PSupervisores
echo "Configurando sudoers para el grupo 2PSupervisores..."
sudo bash -c 'echo "%2PSupervisores ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'

echo "Tareas completadas."
