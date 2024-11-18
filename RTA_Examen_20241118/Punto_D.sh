#!/bin/bash

# Definir la ubicación de los archivos en la estructura de Ansible
DIRECTORIO_ALUMNO="/home/vagrant/repogit/UTNFRA_SO_2do_Parcial_Villan/202406/ansible/tmp/2do_parcial/alumno"
DIRECTORIO_EQUIPO="/home/vagrant/repogit/UTNFRA_SO_2do_Parcial_Villan/202406/ansible/tmp/2do_parcial/equipo"

# Asegurarse de que los directorios existen
mkdir -p "$DIRECTORIO_ALUMNO"
mkdir -p "$DIRECTORIO_EQUIPO"

echo "Generando datos del alumno..."
cat <<EOF > "$DIRECTORIO_ALUMNO/datos_alumno.txt"
Nombre: Ian Mario Villan
Division: 113
EOF

# Obtener información del sistema
IP=$(hostname -I | awk '{print $1}')
DISTRO=$(lsb_release -d | cut -f2)
CORES=$(nproc)

echo "Generando datos del equipo..."
cat <<EOF > "$DIRECTORIO_EQUIPO/datos_equipo.txt"
Ip: $IP
Distribucion: $DISTRO
Cantidad de cores: $CORES
EOF

echo "Configurando sudoers para el grupo 2PSupervisores..."
if ! grep -q "^%2PSupervisores" /etc/sudoers; then
    echo "%2PSupervisores ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    echo "Configuración de sudoers actualizada."
else
    echo "El grupo 2PSupervisores ya tiene configuración en sudoers."
fi

echo "Tareas completadas."
