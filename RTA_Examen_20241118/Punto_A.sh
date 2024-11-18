#!/bin/bash

# Crear volúmenes físicos (PV) solo en /dev/sdc y /dev/sde
sudo pvcreate /dev/sdc /dev/sde

# Crear el grupo de volúmenes vg_datos usando los discos /dev/sdc y /dev/sde
sudo vgcreate vg_datos /dev/sdc /dev/sde  # Usamos ambos discos para un único VG

# Crear un grupo de volúmenes vg_temp para el swap (solo en /dev/sdd o cualquier otro disco libre)
# Asegúrate de que /dev/sdd esté libre para futuras revisiones.
sudo vgcreate vg_temp /dev/sdd  # VG separado para swap (si es necesario, o deja esta línea fuera si prefieres no tocar sdd aún)

# Crear volúmenes lógicos dentro del grupo vg_datos
sudo lvcreate -L 5M -n lv_docker vg_datos  # 5MB para Docker
sudo lvcreate -L 1.5G -n lv_workareas vg_datos  # 1.5GB para la work area

# Crear un volumen lógico para el swap en vg_temp
sudo lvcreate -L 512M -n lv_swap vg_temp  # 512MB para swap

# Formatear los volúmenes lógicos
sudo mkfs.ext4 /dev/vg_datos/lv_docker  # Formatear lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_workareas  # Formatear lv_workareas
sudo mkswap /dev/vg_temp/lv_swap  # Formatear el swap

# Crear directorios de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

# Montar los volúmenes lógicos
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_workareas /work
sudo swapon /dev/vg_temp/lv_swap  # Activar swap

# Añadir los montajes al archivo fstab para persistencia
echo '/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg_datos/lv_workareas /work ext4 defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg_temp/lv_swap none swap sw 0 0' | sudo tee -a /etc/fstab
