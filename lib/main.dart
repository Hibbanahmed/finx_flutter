import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

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
      initialRoute: '/signup',
      routes: appRoutes,
    );
  }
}
