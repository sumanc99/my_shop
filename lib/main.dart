import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart'; // Ensure this points to your home_page.dart
import 'package:my_shop/theme/app_theme.dart';

// Hive and Provider
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/models/sale.dart';
import 'package:my_shop/providers/sale_provider.dart';

// New imports for Auth
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_shop/services/auth_service.dart'; // Your auth service
import 'package:my_shop/screens/registration_screen.dart'; // Your new registration screen
import 'package:my_shop/screens/login_screen.dart'; // Your new login screen

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  // Check if 'isFirstLaunch' is set. Default to true if not found.
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // Initialize Hive
  try {
    await Hive.initFlutter();
    // Register adapters for all your Hive-managed models
    Hive.registerAdapter(SaleAdapter());
    // Open all necessary Hive boxes
    await Hive.openBox<Sale>('sales');
    await AuthService.init(); // Initialize the auth box via AuthService
  } catch (e) {
    // print('Error initializing Hive: $e');
    // Consider adding a graceful error handling here, e.g., showing an error dialog
    // and exiting the app, or continuing with limited functionality.
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SalesProvider()),
      ],
      // Pass the isFirstLaunch flag to MyApp
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: AppTheme.lightTheme,
      // Determine the initial screen based on registration and authentication status
      home: isFirstLaunch
          ? const RegistrationScreen() // If it's the very first app launch, show registration
          : FutureBuilder<bool>( // Otherwise, check if user is already authenticated
              future: AuthService.isAuthenticated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // Handle errors during auth check
                    print('Error checking authentication status: ${snapshot.error}');
                    return const Text('Error loading app.'); // Or an error screen
                  }
                  // If data exists (meaning a shop was registered)
                  if (snapshot.hasData && snapshot.data == true) {
                    return const LoginScreen(); // User has registered, go to login
                  } else {
                    // No registration data found (e.g., app data cleared, or it's a "first launch"
                    // that wasn't caught by the SharedPreferences check due to some specific scenario)
                    return const RegistrationScreen(); // Go to registration
                  }
                }
                // While authentication status is being determined, show a loading indicator
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            ),
      debugShowCheckedModeBanner: false, // Hides the "DEBUG" banner
    );
  }
}