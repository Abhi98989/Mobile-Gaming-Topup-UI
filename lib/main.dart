import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'feature/topup_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top-Up App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F1D2B),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1F1D2B),
        useMaterial3: true,
      ),
      home: const TopupScreen(),
    );
  }
}
