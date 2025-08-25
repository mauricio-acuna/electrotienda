# Sputnik-Core: Estado Actual y Plan de Trabajo Pendiente

## Resumen de Estado

- **Backend:** Java 17, Spring Boot 3.1.2, H2/PostgreSQL, Gradle
- **Seguridad:** JWT, Spring Security, endpoints públicos y protegidos
- **Context Path:** `/api/v1`
- **Compilación:** `gradle clean build -x test` exitosa
- **Ejecución:** `java -jar build/libs/sputnik-core-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev` falla (exit code 1)
- **Endpoints públicos:** `/public/health`, `/public/info` (funcionando en builds previos)
- **Endpoints de autenticación:** `/auth/register`, `/auth/login` (en proceso de refactor y validación)

---

## Tareas Pendientes y Cómo Resolverlas

### 1. Corregir el arranque de la aplicación
- **Acción:** Revisar el log de error completo al ejecutar el JAR.
- **Solución:** Identificar y corregir errores de configuración, beans, dependencias o entidades.
- **Prompt sugerido:**
  ```
  El comando `java -jar build/libs/sputnik-core-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev` falla. Lee el log de error completo y corrige la causa raíz (por ejemplo, beans, entidades, configuración, dependencias, etc.).
  ```

### 2. Validar y finalizar endpoints de autenticación
- **Acción:** Probar `/api/v1/auth/register` y `/api/v1/auth/login` con datos reales.
- **Solución:** Ajustar DTOs, servicios y controladores para que funcionen con el flujo JWT y la base de datos.
- **Prompt sugerido:**
  ```
  Probar los endpoints de registro y login. Si hay errores de validación, DTOs o servicios, corrígelos hasta que el flujo de autenticación funcione y devuelva JWT correctamente.
  ```

### 3. Crear y poblar datos de prueba
- **Acción:** Crear scripts o endpoints para poblar usuarios, productos, categorías, etc.
- **Solución:** Usar Flyway, data.sql, o endpoints de administración para insertar datos de ejemplo.
- **Prompt sugerido:**
  ```
  Crea datos de prueba para usuarios, productos, categorías y órdenes usando scripts SQL o endpoints. Verifica que los endpoints de consulta devuelvan datos correctamente.
  ```

### 4. Validar endpoints protegidos y públicos
- **Acción:** Probar acceso a endpoints públicos y protegidos con y sin JWT.
- **Solución:** Ajustar configuración de seguridad y roles según sea necesario.
- **Prompt sugerido:**
  ```
  Probar acceso a endpoints públicos y protegidos. Ajusta la configuración de Spring Security para que los permisos funcionen según lo esperado.
  ```

### 5. Documentar y dejar ejemplos de uso
- **Acción:** Documentar endpoints, ejemplos de requests/responses y flujos principales.
- **Solución:** Agregar ejemplos curl/Postman y descripciones en el README.
- **Prompt sugerido:**
  ```
  Documenta los endpoints principales con ejemplos de requests y responses. Incluye ejemplos de uso con curl o Postman para registro, login y consulta de productos.
  ```

### 6. Testing básico y validación final
- **Acción:** Agregar tests unitarios y de integración mínimos para endpoints clave.
- **Solución:** Usar JUnit y MockMvc para probar flujos críticos.
- **Prompt sugerido:**
  ```
  Agrega tests unitarios y de integración para los endpoints de autenticación y productos. Asegúrate de que todos los tests pasen antes de dar por finalizado el backend.
  ```

---

## Resumen Humano

- El backend está casi listo pero requiere corregir el arranque y finalizar el flujo de autenticación.
- Se debe poblar la base de datos con datos de ejemplo y probar todos los endpoints clave.
- Es fundamental validar la seguridad y documentar el uso de la API.
- Se recomienda avanzar por bloques, validando cada paso antes de continuar.

---

## Prompts principales para continuar en otro entorno/IA

1. "Lee el log de error de arranque y corrige la causa raíz."
2. "Finaliza y prueba el flujo de registro y login de usuarios con JWT."
3. "Crea y prueba datos de ejemplo para usuarios, productos y órdenes."
4. "Valida la seguridad de los endpoints públicos y protegidos."
5. "Documenta los endpoints y flujos principales con ejemplos."
6. "Agrega tests unitarios y de integración para endpoints críticos."

---

> **Nota:** Cada bloque debe ser validado y probado antes de marcarse como finalizado.
