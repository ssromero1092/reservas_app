# Reservas App

Reservas App es una aplicación desarrollada en Flutter que permite gestionar reservas de manera eficiente y sencilla. Este proyecto está diseñado para facilitar la administración de reservas en diferentes contextos, como restaurantes, hoteles, salas de reuniones, entre otros.

## Tabla de Contenidos

- [Características](#características)
- [Instalación](#instalación)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Uso](#uso)
- [Dependencias](#dependencias)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Características

- Registro y autenticación de usuarios.
- Creación, edición y cancelación de reservas.
- Visualización de reservas activas y pasadas.
- Notificaciones para recordar próximas reservas.
- Interfaz intuitiva y responsiva.
- Soporte multiplataforma (iOS, Android, Web).

## Instalación

1. **Clona el repositorio:**
    ```bash
    git clone https://github.com/tu_usuario/reservas_app.git
    cd reservas_app
    ```

2. **Instala las dependencias:**
    ```bash
    flutter pub get
    ```

3. **Ejecuta la aplicación:**
    ```bash
    flutter run
    ```

## Estructura del Proyecto

```
lib/
├── core/                           # Funcionalidades compartidas
│   ├── constants/                  # Constantes globales
│   ├── di/                         # Inyección de dependencias
│   ├── errors/                     # Manejo de errores
│   ├── network/                    # Cliente HTTP (Dio)
│   ├── routes/                     # Configuración de rutas
│   ├── storage/                    # Almacenamiento local
│   └── theme/                      # Tema de la aplicación
├── features/                       # Características por dominio
│   ├── data/                       # Capa de datos
│   │   ├── datasources/           # Fuentes de datos remotas
│   │   ├── models/                # Modelos de datos
│   │   └── repositories/          # Implementación de repositorios
│   ├── domain/                     # Lógica de negocio
│   │   ├── entities/              # Entidades del dominio
│   │   ├── repositories/          # Contratos de repositorios
│   │   └── usecases/              # Casos de uso
│   └── presentation/              # Capa de presentación
│       ├── blocs/                 # Gestión de estado (BLoC)
│       └── pages/                 # Pantallas y widgets
└── main.dart         
```

- **models/**: Modelos de datos (usuarios, reservas, etc.).
- **screens/**: Pantallas principales de la app.
- **widgets/**: Componentes reutilizables.
- **services/**: Lógica de negocio y conexión con APIs.
- **utils/**: Utilidades y helpers.

## Uso

1. Inicia sesión.
2. Crea una nueva reserva seleccionando fecha, hora y detalles.
3. Consulta tus reservas activas y pasadas.
4. Edita o cancela reservas según sea necesario.
5. Recibe notificaciones de recordatorio.

## Dependencias

Algunas de las principales dependencias utilizadas:

- `flutter`
- `provider` (gestión de estado)
- `http` (peticiones a APIs)
- `firebase_auth` y `cloud_firestore` (autenticación y base de datos)
- `flutter_local_notifications` (notificaciones locales)

Consulta el archivo `pubspec.yaml` para la lista completa.

## Contribuciones

¡Las contribuciones son bienvenidas! Por favor, abre un issue o pull request para sugerencias, mejoras o correcciones.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

Desarrollado por Simon Romero.