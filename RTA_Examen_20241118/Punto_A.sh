# Inicializar volumenes físicos (si es necesario)
sudo pvcreate /dev/sdc /dev/sdd

# Crear grupo de volúmenes
sudo vgcreate vg_datos /dev/sdc
sudo vgcreate vg_temp /dev/sdd

# Crear volúmenes lógicos (ya existen, puedes omitir esta parte si ya están creados)
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp

# Formatear volumen swap
sudo mkswap /dev/vg_temp/lv_swap

# Hacer que el swap sea permanente (agregar al fstab)
echo "/dev/vg_temp/lv_swap none swap sw 0 0" | sudo tee -a /etc/fstab

# Activar el swap
sudo swapon -a

# Formatear volúmenes lógicos para Docker y Workareas
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_workareas

# Crear directorios de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

# Montar los volúmenes lógicos
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_workareas /work

# Hacer que los montajes sean permanentes (agregar al fstab)
echo "/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "/dev/vg_datos/lv_workareas /work ext4 defaults 0 0" | sudo tee -a /etc/fstab
