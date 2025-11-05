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

lib/
┣ screens/
┃ ┣ splash/
┃ ┣ login/
┃ ┣ withdrawals/
┃ ┗ notifications/
┣ widgets/
┣ theme/
┗ main.dart
assets/
┣ images/
┗ screenshots/



This structure ensures modularity, readability, and easy maintenance of the app.

---

## Responsiveness and Design Accuracy
- All screens have been tested on different screen sizes (mobile emulator and physical device).
- Font sizes, paddings, and colors have been carefully adjusted to match the reference UI.
- Used `SingleChildScrollView` and `Flexible` widgets to handle smaller devices.

---

## Screenshots

### Light Theme
| Splash | Login | Withdrawals | Notifications |
|--------|--------|-------------|----------------|
| ![Splash Light](<img src="https://github.com/user-attachments/assets/359c0a5d-b4a5-4fad-b32a-0880a45b0568" width="100"/>) | ![Login Light](<img src="https://github.com/user-attachments/assets/848538fa-b9ac-41e2-a1f1-a9cb9624c033" width="100"/>) | ![Withdrawals Light](<img src="https://github.com/user-attachments/assets/d6fe183b-2279-4e18-a16b-074c016d44af" width="100"/>) | ![Notifications Light](<img src="https://github.com/user-attachments/assets/f476dc88-cbdb-49f3-9f10-b2e65342159c" width="100"/>) |


### Dark Theme
| Splash | Login | Withdrawals | Notifications |
|--------|--------|-------------|----------------|
| ![Splash Dark](<img src="https://github.com/user-attachments/assets/554f3a80-1c76-4be5-bf51-5ee1dfdd4ac0" width="100"/>) | ![Login Dark](<img src="https://github.com/user-attachments/assets/5fa050e9-adf4-4c45-850b-4100771f1318" width="100"/>) | ![Withdrawals Dark](<img src="https://github.com/user-attachments/assets/d950c751-f50d-46e7-999a-84ca9d215def" width="100"/>) | ![Notifications Dark](<img src="https://github.com/user-attachments/assets/f8c476ab-2443-475c-8609-d97fdc38ecb6" width="100"/>) |

---

## Demo Video
A short demo video showcasing the complete app flow (Splash → Login → Withdrawals → Notifications) is available below:

[View Demo Video](#)  
https://youtube.com/shorts/uwxuF6z3RtE?feature=share

---

## APK Download
You can download and test the release build of this project from the following link:

[Download APK](#)  
https://appho.st/d/cei9bLPG

---

## How to Run the Project

```bash
# Clone this repository
git clone https://github.com/kanhaiya8066/flutter_ui_challenge_spaytech.git

# Navigate into the project folder
cd flutter_ui_challenge_spaytech

# Get all dependencies
flutter pub get

# Run the app
flutter run



