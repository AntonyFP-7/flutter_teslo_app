import 'package:flutter/material.dart';
import 'package:teslo_app/config/router/app_router.dart';
import 'package:teslo_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child:MyApp() )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp.router(
    routerConfig: appRouter,
    theme: AppTheme().getTheme(),
    debugShowCheckedModeBanner: false,
  );
  }
}

