# Sistema de Reservas - Flutter App

Una aplicación móvil completa para la gestión de reservas hoteleras desarrollada con Flutter, implementando arquitectura limpia y patrones de diseño modernos.

## 📱 Descripción

El Sistema de Reservas es una aplicación multiplataforma que permite gestionar reservas hoteleras de manera eficiente. La aplicación incluye funcionalidades completas para el manejo de huéspedes, habitaciones, tipos de hospedaje, precios y el ciclo completo de reservas.

## ✨ Características Principales

### 🔐 Autenticación y Seguridad
- Sistema de login seguro con validación de credenciales
- Almacenamiento seguro de tokens usando [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage)
- Gestión automática de sesiones y renovación de tokens
- Logout con limpieza completa de datos locales

### 🏨 Gestión de Entidades
- **Recintos**: Administración de diferentes ubicaciones/edificios
- **Habitaciones**: Gestión completa con capacidad y asignación a recintos
- **Tipos de Hospedaje**: Categorización de alojamientos con equipamiento
- **Tipos de Precio**: Configuración de diferentes esquemas tarifarios
- **Reservas**: Ciclo completo de gestión de reservas

### 🎨 Interfaz de Usuario
- Diseño Material Design 3 moderno
- Tema personalizado con colores corporativos
- Animaciones fluidas y transiciones suaves
- Interfaz responsive para diferentes tamaños de pantalla
- Notificaciones toast informativas

## 🏗️ Arquitectura

La aplicación implementa **Clean Architecture** con las siguientes capas:

### 📁 Estructura del Proyecto
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
└── main.dart                      # Punto de entrada
```

### 🔄 Patrones Implementados

#### Clean Architecture
- **Presentation Layer**: UI, BLoCs, y manejo de estado
- **Domain Layer**: Entidades, casos de uso y contratos
- **Data Layer**: Repositorios, fuentes de datos y modelos

#### Patrón BLoC
- Gestión de estado reactiva con [`flutter_bloc`](https://bloclibrary.dev/)
- Separación clara entre eventos, estados y lógica de negocio
- Estados tipificados para cada entidad

#### Dependency Injection
- Configuración centralizada con [`get_it`](https://pub.dev/packages/get_it)
- Registro automático de dependencias
- Facilita testing y mantenimiento

## 🛠️ Tecnologías y Dependencias

### Principales
```yaml
flutter_bloc: ^8.1.6              # Gestión de estado
get_it: ^8.0.2                    # Inyección de dependencias
go_router: ^14.6.2                # Navegación declarativa
dio: ^5.7.0                       # Cliente HTTP
dartz: ^0.10.1                    # Programación funcional
equatable: ^2.0.7                 # Comparación de objetos
```

### UI y UX
```yaml
toastification: ^2.3.0            # Notificaciones toast
loading_animation_widget: ^1.3.0  # Animaciones de carga
```

### Almacenamiento
```yaml
flutter_secure_storage: ^9.2.2    # Almacenamiento seguro
shared_preferences: ^2.3.3        # Preferencias compartidas
```

### Logging y Debug
```yaml
logger: ^2.5.0                    # Sistema de logging
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Dispositivo/Emulador Android o iOS

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/ssromero1092/reservas_app.git
cd reservas_app
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar variables de entorno**
Editar `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = "https://tu-api.com/api/";
static const String numeroUnico = "TU_NUMERO_UNICO";
```

4. **Ejecutar la aplicación**
```bash
flutter run
```

## 📱 Funcionalidades Detalladas

### 🔑 Sistema de Autenticación

#### Pantalla de Login
- Formulario con validación de campos
- Manejo de estados de carga
- Mensajes de error informativos
- Diseño centrado y responsive

#### Gestión de Sesión
- Verificación automática de tokens al iniciar
- Renovación automática de sesiones
- Logout seguro con limpieza de datos

### 🏠 Pantalla Principal

Dashboard centralizado con:
- **Sección de Operaciones**: Acceso a reservas activas
- **Sección de Maestros**: Gestión de entidades base
- **Panel de Usuario**: Información y opciones de cuenta

### 🏨 Gestión de Recintos

#### Funcionalidades
- ✅ Listar todos los recintos
- ✅ Crear nuevo recinto
- ✅ Editar recinto existente
- ✅ Eliminar recinto
- 🔄 Validaciones de formulario

#### Implementación Técnica
- **Bloc**: Gestión de estado con RecintoBloc
- **Página**: Interfaz de usuario responsive
- **Casos de Uso**: CRUD completo implementado

### 🛏️ Gestión de Habitaciones

#### Funcionalidades
- ✅ Listar habitaciones con información del recinto
- ✅ Crear habitación asignada a recinto
- ✅ Editar información de habitación
- ✅ Eliminar habitación
- 🔄 Dropdown dinámico de recintos

#### Características Técnicas
- Relación con entidad Recinto
- Validación de capacidad
- Estados de carga para dropdowns

### 🏷️ Tipos de Hospedaje

#### Gestión Completa
- Descripción del tipo de hospedaje
- Equipamiento detallado
- CRUD completo con validaciones

### 💰 Tipos de Precio

#### Configuración Tarifaria
- Múltiples esquemas de precios
- Observaciones y descripciones
- Gestión flexible de tarifas

### 📋 Sistema de Reservas

#### Estado Actual
- Listado de reservas existentes
- Información detallada de cada reserva
- Estados de reserva visuales

## 🎨 Diseño y UI/UX

### Tema Visual
- **Colores**: Paleta azul corporativa
- **Typography**: Material Design Typography
- **Iconografía**: Material Icons
- **Layouts**: Responsive y adaptativos

### Componentes Reutilizables
- Cards informativas
- Diálogos modales
- Botones con estados
- Formularios validados

### Animaciones
- Transiciones suaves entre pantallas
- Loading states con spinners
- Toast notifications
- Splash screen animado

## 🔧 Configuración Técnica

### Cliente HTTP (DioClient)
```dart
- Configuración base de Dio
- Interceptores para autenticación
- Manejo automático de headers
- Logging de requests/responses
```

### Almacenamiento Seguro
```dart
- Tokens de autenticación
- Información de usuario
- Configuraciones sensibles
```

### Gestión de Estado
- **Patrón BLoC**: Separación clara de responsabilidades
- **Estados Tipificados**: Loading, Success, Error para cada entidad
- **Eventos Específicos**: CRUD operations como eventos

## 📱 Multiplataforma

### Soporte de Plataformas
- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ Linux
- ✅ macOS

### Configuraciones Específicas
Cada plataforma tiene su configuración optimizada en las carpetas respectivas:
- `android/` - Configuración Android
- `ios/` - Configuración iOS
- `web/` - PWA y configuración web
- `windows/` - App nativa Windows
- `linux/` - App nativa Linux
- `macos/` - App nativa macOS

## 🧪 Testing

### Estructura de Testing
```bash
test/
├── unit/                    # Tests unitarios
├── widget/                  # Tests de widgets
└── integration/             # Tests de integración
```

### Comandos de Testing
```bash
# Tests unitarios
flutter test

# Tests con coverage
flutter test --coverage

# Tests de integración
flutter drive --target=test_driver/app.dart
```

## 📦 Build y Deployment

### Android
```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
# Windows
flutter build windows --release

# Linux  
flutter build linux --release

# macOS
flutter build macos --release
```

## 🔒 Seguridad

### Implementaciones de Seguridad
- 🔐 Almacenamiento encriptado de credenciales
- 🛡️ Validación de tokens JWT
- 🔒 HTTPS obligatorio para comunicaciones
- 🚫 Ofuscación de datos sensibles en logs

### Buenas Prácticas
- No hardcodear credenciales
- Validación client-side y server-side
- Timeouts configurados
- Manejo seguro de errores

## 🚧 Estado del Proyecto

### ✅ Completado
- [x] Autenticación completa
- [x] CRUD de Recintos
- [x] CRUD de Habitaciones  
- [x] CRUD de Tipos de Hospedaje
- [x] CRUD de Tipos de Precio
- [x] Listado de Reservas
- [x] Navegación y routing
- [x] Gestión de estado
- [x] UI/UX responsive

### 🚧 En Desarrollo
- [ ] CRUD completo de Reservas
- [ ] Gestión de Clientes
- [ ] Dashboard con estadísticas
- [ ] Filtros y búsquedas avanzadas
- [ ] Notificaciones push
- [ ] Modo offline

### 📋 Roadmap Futuro
- [ ] Integración con calendarios
- [ ] Reportes y analytics
- [ ] Multi-idioma
- [ ] Tema oscuro/claro
- [ ] Backup automático
- [ ] API GraphQL

## 👥 Contribución

### Cómo Contribuir
1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit tus cambios (`git commit -am 'Agrega nueva característica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Crear un Pull Request

### Estándares de Código
- Seguir las convenciones de Dart/Flutter
- Documentar funciones y clases importantes
- Escribir tests para nueva funcionalidad
- Mantener la arquitectura limpia

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Soporte y Contacto

- **Email**: soporte@sistemaslh.cl
- **Documentación API**: https://sistemaslh.cl/reservas/api/docs
- **Issues**: Usar el sistema de issues de GitHub

## 🔄 Changelog

### v1.0.0 (2025-01-XX)
- 🎉 Lanzamiento inicial
- ✨ CRUD completo para entidades principales
- 🎨 UI/UX Material Design 3
- 🔐 Sistema de autenticación seguro
- 📱 Soporte multiplataforma

---

**Desarrollado con ❤️ usando Flutter**
