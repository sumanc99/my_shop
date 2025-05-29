import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/theme/app_theme.dart';

// hive and provider
 // importing why to access hive
  import 'package:hive_flutter/hive_flutter.dart';
  import 'package:provider/provider.dart';
  // the structure and adapter for my data model
  import 'package:my_shop/models/sale.dart';
  // // the provider for my data model
  import 'package:my_shop/providers/sale_provider.dart';

void main() async {
  // let make sure the flutter engine is ready
  WidgetsFlutterBinding.ensureInitialized();
   try {
      await Hive.initFlutter();
      Hive.registerAdapter(SaleAdapter());
      await Hive.openBox<Sale>('sales');
    } catch (e) {
      // print('Error initializing Hive: $e');
    }
  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_) => SalesProvider()),
        ],
        child: const MyApp(),
      ),

    // const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'My Shop'),
      debugShowCheckedModeBanner: false, // Hides the "DEBUG" banner
    );
  }
}

