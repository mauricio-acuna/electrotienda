# Sputnik-Core

## Descripción

Sputnik-Core es una plataforma e-commerce integral para la venta de dispositivos electrónicos, especializada en telefonía móvil, con capacidades de marketplace para intercambio de productos usados entre usuarios.

## Tecnologías

- **Backend**: Java 17 + Spring Boot 3.x
- **Frontend**: Angular 16+
- **Base de Datos**: PostgreSQL 15+
- **Cache**: Redis
- **Seguridad**: Spring Security + JWT
- **Containerización**: Docker & Docker Compose

## Arquitectura

```
Frontend (Angular) ←→ Backend (Spring Boot) ←→ PostgreSQL
                                    ↓
                                  Redis
```

## Características Principales

### E-commerce B2C
- Catálogo de productos electrónicos
- Carrito de compras
- Sistema de órdenes
- Gestión de inventario
- Sistema de pagos

### Marketplace C2C
- Listados de productos usados
- Sistema de transacciones P2P
- Reputación de vendedores
- Reviews y calificaciones

### Gestión Multi-tienda
- Soporte para franquicias
- Inventario distribuido
- Configuración por sucursal

## Prerrequisitos

- Java 17 o superior
- Maven 3.6 o superior
- Docker y Docker Compose
- Node.js 16+ (para el frontend)

## Instalación y Configuración

### 1. Clonar el repositorio

```bash
git clone <repository-url>
cd sputnik-core
```

### 2. Levantar servicios con Docker

```bash
# Levantar PostgreSQL y Redis
docker-compose up -d postgres redis

# Opcional: Levantar herramientas de administración
docker-compose --profile tools up -d pgadmin redis-commander
```

### 3. Configurar base de datos

La base de datos se configura automáticamente con Flyway. Las migraciones se ejecutan al iniciar la aplicación.

**Acceso a pgAdmin** (si se levantó):
- URL: http://localhost:8080
- Email: admin@sputnik-core.com
- Password: admin123

### 4. Ejecutar la aplicación

```bash
# Opción 1: Con Maven
./mvnw spring-boot:run

# Opción 2: Compilar y ejecutar JAR
./mvnw clean package
java -jar target/sputnik-core-0.0.1-SNAPSHOT.jar

# Opción 3: Con Docker
docker build -t sputnik-core .
docker run -p 8080:8080 --network sputnik-core_sputnik-network sputnik-core
```

### 5. Verificar la instalación

- **API**: http://localhost:8080/api/v1/actuator/health
- **Swagger UI**: http://localhost:8080/swagger-ui/index.html
- **pgAdmin**: http://localhost:8080 (si está habilitado)
- **Redis Commander**: http://localhost:8081 (si está habilitado)

## Configuración de Perfiles

### Desarrollo (dev)
```yaml
spring:
  profiles:
    active: dev
```

### Producción (prod)
```yaml
spring:
  profiles:
    active: prod
```

## Variables de Entorno

Para producción, configurar las siguientes variables:

```bash
DATABASE_URL=jdbc:postgresql://localhost:5432/sputnik_core_prod
DATABASE_USERNAME=sputnik_user
DATABASE_PASSWORD=your_secure_password
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password
JWT_SECRET=your_jwt_secret_key
CORS_ALLOWED_ORIGINS=https://yourdomain.com
```

## API Endpoints

### Autenticación
- `POST /api/v1/auth/login` - Inicio de sesión
- `POST /api/v1/auth/register` - Registro de usuario
- `POST /api/v1/auth/refresh` - Renovar token

### Productos
- `GET /api/v1/products` - Listar productos
- `GET /api/v1/products/{id}` - Obtener producto
- `POST /api/v1/admin/products` - Crear producto (Admin)
- `PUT /api/v1/admin/products/{id}` - Actualizar producto (Admin)

### Marketplace
- `GET /api/v1/marketplace/listings` - Listar productos usados
- `POST /api/v1/seller/listings` - Crear listado (Vendedor)
- `GET /api/v1/marketplace/listings/{id}` - Obtener listado

### Órdenes
- `GET /api/v1/orders` - Mis órdenes
- `POST /api/v1/orders` - Crear orden
- `GET /api/v1/orders/{id}` - Obtener orden

## Estructura del Proyecto

```
src/
├── main/
│   ├── java/
│   │   └── com/sputnik/core/
│   │       ├── SputnikCoreApplication.java
│   │       ├── config/          # Configuraciones
│   │       ├── controller/      # REST Controllers
│   │       ├── service/         # Lógica de negocio
│   │       ├── repository/      # Repositorios JPA
│   │       ├── entity/          # Entidades JPA
│   │       ├── dto/             # DTOs
│   │       ├── security/        # Configuración de seguridad
│   │       └── exception/       # Manejo de excepciones
│   └── resources/
│       ├── application.yml      # Configuración principal
│       ├── application-dev.yml  # Configuración desarrollo
│       ├── application-prod.yml # Configuración producción
│       └── db/migration/        # Scripts de Flyway
└── test/                        # Tests unitarios e integración
```

## Testing

```bash
# Ejecutar todos los tests
./mvnw test

# Ejecutar tests de integración
./mvnw test -Dtest="**/*IntegrationTest"

# Ejecutar tests con cobertura
./mvnw test jacoco:report
```

## Desarrollo

### Comandos útiles

```bash
# Limpiar y compilar
./mvnw clean compile

# Ejecutar en modo desarrollo (hot reload)
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=dev"

# Generar JAR sin tests
./mvnw clean package -DskipTests

# Verificar dependencias vulnerables
./mvnw dependency:check

# Actualizar dependencias
./mvnw versions:display-dependency-updates
```

### Hot Reload

Con Spring Boot DevTools habilitado, la aplicación se recarga automáticamente cuando se detectan cambios en el classpath.

## Monitoring y Observabilidad

### Actuator Endpoints

- `/actuator/health` - Estado de la aplicación
- `/actuator/info` - Información de la aplicación
- `/actuator/metrics` - Métricas de la aplicación
- `/actuator/prometheus` - Métricas para Prometheus

### Logs

Los logs se configuran en `application.yml` y se pueden enviar a diferentes destinos según el perfil.

## Troubleshooting

### Problemas Comunes

1. **Error de conexión a PostgreSQL**
   ```bash
   docker-compose up -d postgres
   docker-compose logs postgres
   ```

2. **Error de conexión a Redis**
   ```bash
   docker-compose up -d redis
   docker-compose logs redis
   ```

3. **Error de permisos en Maven**
   ```bash
   chmod +x mvnw
   ```

4. **Puerto 8080 ocupado**
   ```bash
   # Cambiar puerto en application.yml
   server:
     port: 8081
   ```

## Contribución

1. Fork del proyecto
2. Crear una rama feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit de cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crear un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Contacto

- **Email**: dev@sputnik-core.com
- **Documentación**: [Wiki del proyecto]
- **Issues**: [GitHub Issues]

## Roadmap

### Fase 1 - MVP ✅
- [x] Configuración inicial del proyecto
- [x] Estructura base de la aplicación
- [x] Configuración de base de datos
- [x] Sistema básico de autenticación
- [ ] CRUD de productos
- [ ] Carrito de compras básico

### Fase 2 - Marketplace
- [ ] Sistema de listados P2P
- [ ] Reviews y calificaciones
- [ ] Sistema de transacciones

### Fase 3 - Multi-tienda
- [ ] Gestión de sucursales
- [ ] Inventario distribuido
- [ ] Reporting avanzado

### Fase 4 - Optimización
- [ ] Performance tuning
- [ ] Mobile app
- [ ] Analytics avanzados
