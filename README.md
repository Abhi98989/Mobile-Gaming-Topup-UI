# TopUp Mobile Game App

A Flutter application for topping up mobile game credits.

## Features

- Beautiful dark UI design
- Diamond package selection
- Email validation
- Payment method selection screen
- Phone number input
- Confirmation modal
- Responsive layout

## Screenshots

![TopUp Screen](screenshots/topup_screen.png)
![Payment Screen](screenshots/payment_screen.png)

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- A connected device (physical or emulator)

### Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Dependencies

- flutter: SDK
- cupertino_icons: ^1.0.8
- http: ^1.1.0
- cached_network_image: ^3.3.0
- google_fonts: ^4.0.4

## Code Structure

- `lib/feature/topup_screen.dart` - Main TopUp screen UI and functionality
- `lib/feature/payment_screen.dart` - Payment method selection screen
- `lib/main.dart` - App entry point and theme configuration

## How to Use

1. Open the app
2. Your Game ID and Server ID are displayed
3. Select a diamond package
4. Enter your email address
5. Press the arrow button to proceed to payment
6. On the payment screen, select your preferred payment method
7. Enter your phone number
8. Complete the purchase
