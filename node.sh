#!/bin/bash

echo "Masukkan nama lokasi: "
read location_name
echo "Masukkan deskripsi lokasi: "
read location_description
echo "Masukkan domain: "
read domain
echo "Masukkan nama node: "
read node_name
echo "Masukkan Locid: "
read locid

total_memory=16000000
memory_overallocation=0
total_disk_space=11600000000
disk_overallocation=0

cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

php artisan p:location:make <<EOF
$location_name
$location_description
EOF

php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$total_memory
$memory_overallocation
$total_disk_space
$disk_overallocation
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

# Pterodactyl tidak punya command p:node:allocation, pakai API atau manual di panel
echo "Silakan tambahkan port allocation secara manual di panel atau gunakan API."

echo "Proses pembuatan lokasi dan node telah selesai."
