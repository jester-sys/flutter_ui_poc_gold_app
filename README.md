# Flutter UI Challenge – Spay Technology

This repository contains a Flutter-based Proof of Concept (POC) project developed for the Android Developer Final Assignment at Spay Technology.

The purpose of this assignment is to demonstrate practical Flutter UI development skills, code quality, and attention to detail through a production-grade app design and implementation.

---

## Overview

The project implements a complete three-screen mobile application workflow with a splash screen, login functionality, withdrawal management screen, and notifications.  
All screens are designed based on the provided UI references and include additional enhancements for better user experience and presentation.

The app is built using the Flutter SDK and follows clean architecture principles, including logical folder structure, responsive UI, and theme-based design.

---

## Features Implemented

### 1. Splash Screen
- A custom animated splash screen designed using AI-generated visuals.  
- The splash screen smoothly transitions to the login page after a short delay.
- Animation implemented using Flutter’s `AnimationController` and `FadeTransition`.
- Provides a professional first impression and realistic app flow.

### 2. Login Screen
- Fully responsive login UI matching the provided design reference.
- Includes email and password input fields with validation.
- Offline validation logic implemented to simulate user authentication without backend dependency.
- “Forgot Password?” clickable text implemented for UI completeness.
- Gradient login button with proper shadow and elevation effects.
- Clean and minimalistic layout with consistent spacing and typography.

### 3. Withdrawals Screen
- Displays key financial metrics:
  - Total Withdrawn
  - Total Transactions
  - Success Rate
- Added a filter tab section to switch between:
  - All
  - Completed
  - Processing
  - Failed
- Each transaction card includes:
  - Transaction Type
  - Bank or Wallet Info
  - Reference ID
  - Fee, Date, and Amount (negative amounts shown in red)
  - Status chip (Completed / Processing / Failed)
- Responsive list layout using `ListView.separated()`.
- Smooth navigation and properly aligned components.

### 4. Notifications Screen
- Integrated notification section accessible via the header notification icon.
- Contains:
  - Notification settings card with a working switch widget.
  - Scrollable list of notification cards with icon, title, description, and timestamp.
  - Tag system to categorize notifications as “Price Alert”, “Transaction”, or “Security”.
- Implemented **filter/grouping** logic to sort notifications based on category.
- Clean design using cards with rounded corners and subtle shadows.

### 5. Theme Support (Dark and Light Mode)
- Dynamic theme switching implemented for better user accessibility.
- Light and dark themes defined in a centralized theme file (`theme.dart`).
- Theme can be toggled at runtime, providing instant color and background transitions.
- Both themes tested for visual consistency and readability.

### 6. Offline Validation and Navigation
- Basic offline validation ensures the app can operate without an active network.
- Navigation flow implemented using `Navigator.pushReplacement()` for smooth transitions.
- Ensures a realistic application experience even during testing.

---

## Technical Overview

**Tech Stack:**
- Flutter SDK: 3.x
- Language: Dart
- IDE: Android Studio
- Architecture: Clean UI Structure (Screens, Widgets, Theme, Assets)
- State Management: setState (simple and efficient for this scope)

**Libraries Used:**
- `flutter/material.dart`
- `flutter_native_splash` (optional, for native-level splash)
- `google_fonts` (for consistent typography, optional)

---

## Folder Structure


