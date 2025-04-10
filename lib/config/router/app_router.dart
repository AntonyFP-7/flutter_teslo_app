import 'package:go_router/go_router.dart';
import 'package:teslo_app/features/auth/presentation/screens/check_auth_status_screem.dart';
import 'package:teslo_app/features/auth/presentation/screens/login_screen.dart';
import 'package:teslo_app/features/auth/presentation/screens/register_screen.dart';
import 'package:teslo_app/features/products/presentation/products_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const CheckAuthStatusScreem(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
