import 'package:flutter/material.dart';

import 'package:finx_v1/screens/auth/signup_screen.dart';
import 'package:finx_v1/screens/auth/login_screen.dart';
import 'package:finx_v1/screens/auth/forgot_password_screen.dart';
import 'package:finx_v1/screens/auth/profile_setup_screen.dart';

import 'package:finx_v1/screens/main_tab_view.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/signup': (context) => SignUpScreen(),
  '/login': (context) => LoginScreen(),
  '/forgot': (context) => ForgotPasswordScreen(),
  '/setup': (context) => ProfileSetupScreen(),
  '/main': (context) => MainTabView(),
};
