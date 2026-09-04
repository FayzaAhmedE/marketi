# Marketi - E-Commerce Mobile Application 🛒📱

**Marketi** is a modern e-commerce mobile application built using **Flutter** and **Clean Architecture** principles. The app provides a smooth shopping experience for users to browse products, explore categories, view special offers, and manage their profile.

---

## Features

- **Authentication System:** Secure Sign In, Sign Up, and Forgot Password flows using JWT Tokens.
- **Home Screen:** Dynamic display of categories, popular products, special deal banners, and search functionality.
- **Secure Token Storage:** Automatic request authorization management with `FlutterSecureStorage` and `Dio Interceptors`.
- **State Management:** Clean state handling and UI updates using `Flutter BLoC` / `Cubit`.
- **API Integration:** Asynchronous REST API consumption for dynamic product and category fetching.

---

## Tech Stack & Architecture

- **Framework:** Flutter
- **Language:** Dart
- **Architecture:** Clean Architecture (Feature-first structure)
- **State Management:** `flutter_bloc` / `Cubit`
- **Network & API:** `dio`
- **Secure Storage:** `flutter_secure_storage`
- **Navigation & Routing:** On-Generate Dynamic Routing

---

## Project Structure

```text
lib/
 ├── core/
 │    ├── constants/       # App colors, themes, and asset paths
 │    ├── helpers/         # Secure storage & helper utilities
 │    ├── networking/      # Dio client & API interceptors
 │    └── routing/         # App routes & navigation setup
 └── features/
      ├── auth/            # Login, Signup, Forgot Password
      ├── home/            # Home screen, Categories, Products
      ├── profile/         # User profile management
      └── splash/          # Splash & Onboarding screens
