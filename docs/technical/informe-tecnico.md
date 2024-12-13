# Informe Técnico: Implementación de Infraestructura Segura

## Introducción
En el actual panorama digital, donde las amenazas cibernéticas son cada vez más sofisticadas, este proyecto implementa una infraestructura virtualizada segura utilizando tecnologías modernas como Docker. La solución desarrollada se enfoca en la segmentación de red mediante tres áreas críticas, garantizando un control granular del acceso y la protección de datos.

## Diseño de Red
La arquitectura implementada utiliza Docker como base para la virtualización, proporcionando una solución eficiente que reemplaza la infraestructura física tradicional. El diseño se divide en tres segmentos principales:

### Red de Administración (172.20.0.0/24)
- Control centralizado de seguridad
- Acceso completo para tareas de gestión
- Monitoreo continuo de la infraestructura

### Red de IT/Aplicaciones (172.21.0.0/24)
- Servidor web con la tienda en línea
- Base de datos MySQL para gestión de datos
- Comunicaciones cifradas entre componentes

### Red de Operaciones (172.22.0.0/24)
- Acceso restringido solo a servicios necesarios
- Interfaz gráfica para operaciones diarias

## Implementación de Seguridad
Las medidas de seguridad implementadas incluyen:
- Firewall UFW con reglas específicas por segmento
- Sistema de monitoreo continuo
- Políticas de acceso basadas en el principio de mínimo privilegio

## Resultados de Pruebas de Seguridad
Las pruebas realizadas con herramientas especializadas demostraron:
- Efectividad de la segmentación de red
- Protección adecuada contra accesos no autorizados
- Funcionamiento correcto de las políticas de firewall

## Conclusiones
La implementación demuestra una arquitectura robusta y segura, cumpliendo con los objetivos de protección de datos y control de acceso, mientras mantiene la usabilidad necesaria para las operaciones diarias.
