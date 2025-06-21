import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'package:finx_v1/screens/home/home_screen.dart';

void main() {
  runApp(FinXApp());
}

class FinXApp extends StatelessWidget {
  const FinXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),

      // Disable this temporarily to show HomeScreen directly:
      // initialRoute: '/signup',
      home: const HomeScreen(),

      routes: appRoutes,
    );
  }
}
