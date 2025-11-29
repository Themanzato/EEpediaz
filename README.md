# 🧟 EEpedia Z

**EEpedia Z** es una aplicación móvil desarrollada en Flutter que sirve como enciclopedia completa para los jugos de zombies de Call of Duty. Los usuarios pueden explorar mapas, easter eggs, reseñas de la comunidad y gestionar su perfil, todo con integración de Firebase.

## 📱 Características

- **🗺️ Exploración de Mapas**: Navega por una extensa colección de mapas de zombies de diferentes juegos de Call of Duty
- **🎮 Información de Juegos**: Detalles completos de cada entrega de la saga con sus respectivos mapas
- **🥚 Easter Eggs**: Descubre y aprende sobre los easter eggs de cada mapa
- **⭐ Sistema de Reseñas**: Lee y escribe reseñas sobre mapas y easter eggs
- **👥 Comunidad**: Interactúa con otros jugadores y comparte tu experiencia
- **👤 Perfil de Usuario**: Gestiona tu cuenta y preferencias personales
- **🔐 Autenticación Firebase**: Inicio de sesión seguro con Firebase Auth
- **☁️ Cloud Firestore**: Almacenamiento en tiempo real de datos

## 🏗️ Arquitectura

El proyecto sigue una arquitectura limpia con separación de responsabilidades:

```
lib/
├── models/              # Modelos de datos
│   ├── game.dart
│   ├── map.dart
│   ├── review.dart
│   ├── user.dart
│   └── firebase_*.dart  # Modelos específicos de Firebase
├── providers/           # Gestión de estado con Riverpod
│   ├── auth_provider.dart
│   ├── game_provider.dart
│   ├── map_provider.dart
│   ├── review_provider.dart
│   └── navigation_provider.dart
├── services/            # Lógica de negocio y llamadas a APIs
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   ├── game_service.dart
│   ├── map_service.dart
│   └── review_service.dart
├── views/               # Interfaz de usuario
│   ├── pages/           # Páginas principales
│   └── screens/         # Pantallas individuales
├── widgets/             # Componentes reutilizables
└── main.dart            # Punto de entrada
```

## 🛠️ Tecnologías Utilizadas

- **Flutter SDK**: ^3.7.0
- **Dart**: ^3.7.0
- **Gestión de Estado**: Flutter Riverpod ^2.4.9
- **Navegación**: Go Router ^12.1.3
- **Backend**: Firebase
  - Firebase Core ^2.24.2
  - Cloud Firestore ^4.13.6
- **UI/UX**:
  - Google Fonts ^6.1.0
  - Font Awesome Flutter ^10.6.0
  - Cupertino Icons ^1.0.8

## 📋 Requisitos Previos

- Flutter SDK 3.7.0 o superior
- Dart 3.7.0 o superior
- Android Studio / VS Code con extensiones de Flutter
- Cuenta de Firebase con proyecto configurado
- Git

## 🚀 Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tuusuario/eepedia_z.git
   cd eepedia_z
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase**
   - Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Descarga los archivos de configuración:
     - `google-services.json` para Android (colocar en `android/app/`)
     - `GoogleService-Info.plist` para iOS (colocar en `ios/Runner/`)
   - El archivo `firebase_options.dart` ya está incluido en el proyecto

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 🔥 Configuración de Firebase

### Servicios necesarios:
- **Authentication**: Para gestión de usuarios
- **Cloud Firestore**: Para almacenamiento de datos

### Colecciones de Firestore:
- `games`: Información de juegos
- `maps`: Detalles de mapas
- `easter_eggs`: Easter eggs de cada mapa
- `reviews`: Reseñas de usuarios
- `users`: Perfiles de usuario

## 📱 Pantallas Principales

- **Login Screen**: Autenticación de usuarios
- **Home Screen**: Pantalla principal con juegos destacados
- **Maps Screen**: Exploración de mapas disponibles
- **Map Detail Screen**: Información detallada de cada mapa
- **Community Screen**: Interacción con la comunidad
- **Profile Screen**: Gestión de perfil de usuario

## 🧪 Testing

```bash
flutter test
```

## 📦 Compilación

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es privado y no está publicado en pub.dev.

## 👨‍💻 Autor

Desarrollado por el equipo de Zombers

## 📞 Contacto

Para preguntas o sugerencias, por favor abre un issue en el repositorio.

---

**Nota**: Este proyecto está en desarrollo activo. Las características y la documentación pueden cambiar.
