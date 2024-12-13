# export-gns3.sh
#!/bin/bash
# Script para exportar a GNS3

EXPORT_DIR="gns3-export"
DATE=$(date +%Y%m%d)

mkdir -p $EXPORT_DIR

# Exportar contenedores
docker save admin-server > $EXPORT_DIR/admin-server-$DATE.tar
docker save app-server > $EXPORT_DIR/app-server-$DATE.tar
docker save db-server > $EXPORT_DIR/db-server-$DATE.tar
