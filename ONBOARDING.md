# Guía de Onboarding y Evolución para Sputnik-Core (Electrotienda)

---

## 1. Descripción General

Sputnik-Core es una plataforma e-commerce y marketplace modular, basada en Spring Boot, Angular y PostgreSQL. Permite la gestión de productos, usuarios, órdenes y listados P2P, con autenticación JWT y roles diferenciados.

---

## 2. Estructura y Módulos Principales

- **Backend (Java/Spring Boot):**
  - `config/`: Configuraciones generales y de seguridad.
  - `controller/`: REST Controllers para cada módulo.
  - `service/`: Lógica de negocio.
  - `repository/`: Acceso a datos (JPA).
  - `entity/`: Entidades del modelo de datos.
  - `dto/`: Objetos de transferencia de datos.
  - `security/`: Configuración de autenticación y autorización.
  - `exception/`: Manejo de errores.

- **Frontend (Angular):**
  - `core/`: Servicios y guardas de autenticación.
  - `features/`: Módulos funcionales (admin, auth, marketplace, orders, products).
  - `shared/`: Componentes reutilizables y modelos.

- **Infraestructura:**
  - Docker, Docker Compose, Flyway para migraciones, Redis para cache.

---

## 3. Guía de Funcionamiento

- **Autenticación:** OAuth2 y JWT. Roles: Cliente, Vendedor, Admin, Super Admin.
- **Gestión de Productos:** CRUD, categorización, inventario por sucursal.
- **Marketplace:** Listados P2P, validación de productos usados, comisiones, mediación.
- **Órdenes y Pagos:** Carrito, checkout, integración con pasarelas.
- **Monitoring:** Actuator endpoints, logs configurables, métricas Prometheus.

---

## 4. Instalación y Puesta en Marcha

### Requisitos
- Java 17+
- Node.js 18+
- PostgreSQL
- Redis

### Pasos
1. Clonar el repositorio.
2. Configurar variables de entorno (ver sección en README).
3. Ejecutar migraciones con Flyway.
4. Levantar servicios con Docker Compose.
5. Ejecutar backend y frontend:
   - Backend: `./mvnw spring-boot:run`
   - Frontend: `npm install && ng serve`

### Verificación
- API: `http://localhost:8080/api/v1/actuator/health`
- Swagger: `http://localhost:8080/swagger-ui/index.html`

---

## 5. Mantenimiento y Buenas Prácticas

- **Versionado:** Usar ramas feature, PRs y revisiones de código.
- **Testing:** JUnit y MockMvc para backend, Jasmine/Karma para frontend.
- **Documentación:** Mantener README, PRD y ejemplos de uso actualizados.
- **Seguridad:** Validar roles y JWT en endpoints protegidos.
- **Datos de Prueba:** Scripts SQL y endpoints de administración para poblar datos.
- **Logs y Monitoring:** Configurar logs por perfil, usar Actuator y Prometheus.

---

## 6. Guía para Producción

- Configurar variables de entorno seguras.
- Usar `application-prod.yml` y perfil `prod`.
- Ejecutar migraciones antes de levantar el servicio.
- Habilitar HTTPS y CORS restrictivo.
- Configurar backups automáticos de la base de datos.
- Monitorizar con Prometheus y alertas.

---

## 7. Guía Evolutiva y Onboarding

### Primeros Pasos
- Leer README, PRD y roadmap.
- Revisar estructura de carpetas y principales módulos.
- Probar endpoints con Postman/curl (ejemplos en README).
- Ejecutar tests y verificar cobertura.

### Evolución
- Seguir el roadmap y fases de desarrollo.
- Validar cada bloque antes de avanzar.
- Documentar nuevas funcionalidades y flujos.
- Mantener ejemplos de requests/responses actualizados.

### Prompts para IA/Automatización
- "Finaliza y prueba el flujo de registro y login de usuarios con JWT."
- "Crea y prueba datos de ejemplo para usuarios, productos y órdenes."
- "Valida la seguridad de los endpoints públicos y protegidos."
- "Documenta los endpoints y flujos principales con ejemplos."
- "Agrega tests unitarios y de integración para endpoints críticos."

---

## 8. Recursos y Contacto

- **Wiki del proyecto:** (añadir enlace si existe)
- **PRD:** `PRD.md`
- **Estado y tareas:** `README_status.md`
- **Contacto:** dev@sputnik-core.com
