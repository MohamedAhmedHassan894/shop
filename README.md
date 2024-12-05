# Shop App

This is a simple Flutter application to display insights from a list of orders stored in a local JSON file.
How to Run the Project

    Clone the Repository:

git clone https://github.com/your-github-account/flapkap-orders-insights.git
cd flapkap-orders-insights

Ensure FVM is Installed:

    The project uses Flutter Version Management (FVM).
    Install FVM:

dart pub global activate fvm

Set Flutter version to 3.24.2:

    fvm use 3.24.2

Install Dependencies:

fvm flutter pub get

Place the orders.json File:

    Place the orders.json file in the assets/ folder.

Update pubspec.yaml: Ensure the following line is added under flutter > assets:

assets:
- assets/orders.json

Run the App:

    fvm flutter run

Requirements

    Flutter: 3.24.2 (via FVM)
    Dart: Compatible with Flutter 3.24.2

That’s it! The app should now run on your device or emulator. Let me know if you need further assistance.