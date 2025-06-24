graph LR
    A[Error de Instalación] --> B{¿Paquete disponible?}
    B -->|Sí| C[Instalar normalmente]
    B -->|No| D[Buscar alternativas]
    D --> E[Repositorio Git]
    D --> F[Paquete local]
    D --> G[Mock temporal]
    E --> H[Verificar requisitos]
    F --> H
    G --> H
    H --> I[Actualizar CI/CD]
    I --> J[Documentar solución]o

