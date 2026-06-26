# Sokrio User App

A clean, responsive Flutter mobile application that fetches and displays user profiles from a public API, implementing paginated infinite scrolling, local offline caching, and real-time search filtering.

Built using **Clean Architecture** principles and production-ready design practices.

### 📥 Direct Download
👉 [**Download APK v1.0.0**](https://github.com/Zaminur151/sokrio-user-app/releases/download/v1.0.0/app-release.apk)

---

## 📸 App Screenshots

<p align="center">
  <img src="screenshots/Screenshot_1782490285.png" width="320" alt="Users List Screen"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/Screenshot_1782490306.png" width="320" alt="User Details Screen"/>
</p>

---

## 📱 Features

- **User List Screen**: Fetches and renders a clean listing of users with names and profile pictures.
- **User Detail Screen**: Shows a detailed card profile of the selected user with high-res avatars, contact metrics.
- **Infinite Scroll Pagination**: Automatically fetches batches of 10 users as you scroll near the bottom and halts gracefully when the maximum pages are loaded.
- **Local Search Filtering**: Performs case-insensitive matching by name. Works seamlessly both online and offline.
- **Offline Caching**: Caches loaded users locally, enabling instant launches and fallback search utility even when network is unavailable.
- **Micro-Animations**: Smooth hero image transitions and subtle card hover gestures for a premium UI experience.

---

## 🛠️ Technical Stack

| Layer / Role | Tool / Dependency | Purpose |
| :--- | :--- | :--- |
| **Architecture Pattern** | Clean Architecture | Clear separation of concerns across Core, Domain, Data, and Presentation layers. |
| **State Management** | [Provider](https://pub.dev/packages/provider) | Manages widget state lifecycles and notifies UI changes reactively. |
| **Dependency Injection** | [GetIt](https://pub.dev/packages/get_it) | Registers and provides global access to services, repositories, and providers. |
| **Networking Client** | [Dio](https://pub.dev/packages/dio) | Handles HTTP network requests, query parameters, and timeout limits (10s). |
| **HTTP Request Logging** | [PrettyDioLogger](https://pub.dev/packages/pretty_dio_logger) | Formats and logs request/response headers, body payloads, and errors in console. |
| **API Authentication** | Custom Header | Attaches `x-api-key: free_user_3FdkgBKPLlZVRRyBrRPbq5k0JjM` globally to all requests. |
| **Local Cache Storage** | [SharedPreferences](https://pub.dev/packages/shared_preferences) | Persists JSON serialized lists of users on the disk for offline support. |
| **Internet Connectivity** | [ConnectivityPlus](https://pub.dev/packages/connectivity_plus) | Inspects device connectivity status to fallback on cached users when offline. |

---

## 🏗️ Architecture Design

The project is structured according to **Clean Architecture** directories:

```
lib/
├── core/                  
│   ├── di/                
│   ├── errors/            
│   ├── network/           
│   └── theme/             
│
├── domain/                
│   ├── entities/          
│   ├── repositories/      
│   └── usecases/          
│
├── data/                  
│   ├── datasources/      
│   ├── models/          
│   └── repositories/      
│
└── presentation/          
    ├── providers/         
    ├── pages/             
    └── widgets/          
```

---

## 🧪 Testing

The project has robust unit and widget test coverage:
1. **API Mock Testing**: Tests network endpoints, mock request responses, and custom exception mappings without executing actual HTTP client queries.
2. **Widget Layout Layout**: Simple unit testing of standard layouts like custom tiles.

Run the test suite:
```bash
flutter test
```

Verify compile checks:
```bash
flutter analyze
```

---

## 🚀 Getting Started

### 📋 Prerequisites
- Flutter SDK (version `^3.11.5` or higher)

### 💻 Installation
1. Clone the repository and navigate to the project directory:
   ```bash
   cd sokrio_user
   ```

2. Download and fetch package dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```
