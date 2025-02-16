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

default_ram_disk=1600000

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
$default_ram_disk
$default_ram_disk
0
0
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

php artisan p:node:allocation <<EOF
$node_name
0.0.0.0
HOSTING
2000-2500
EOF

echo "Proses pembuatan lokasi, node, dan port allocation telah selesai."
