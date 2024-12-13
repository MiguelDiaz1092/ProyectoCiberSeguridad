# Proyecto de Infraestructura de Ciberseguridad

Este proyecto implementa una infraestructura de red virtualizada y segura utilizando Docker, enfocándose en la segmentación de red y la implementación de políticas de seguridad robustas.

## Descripción

La infraestructura está diseñada con tres segmentos principales:
- Red de Administración (172.20.0.0/24)
- Red de IT/Aplicaciones (172.21.0.0/24)
- Red de Operaciones (172.22.0.0/24)

Cada segmento está aislado y protegido mediante reglas de firewall específicas, garantizando el principio de mínimo privilegio.

## Estructura del Proyecto
ProyectoCiberSeguridad/
├── docker/           # Configuraciones de contenedores
├── docs/            # Documentación y capturas
├── security/        # Scripts y configuraciones de seguridad
└── README.md        # Este archivo


## Implementación

Para implementar este proyecto:

1. Clonar el repositorio
2. Configurar las variables de entorno
3. Ejecutar docker-compose up -d

## Tecnologías Utilizadas

- Docker y Docker Compose
- UFW (Uncomplicated Firewall)
- Sistema de monitoreo personalizado
- VNC para interfaces gráficas

## Documentación

La documentación completa del proyecto se encuentra en la carpeta docs/, incluyendo:
- Informe técnico detallado
- Diagramas de red
- Resultados de pruebas de seguridad
