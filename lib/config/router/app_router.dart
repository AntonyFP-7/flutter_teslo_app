import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_app/config/router/app_router_notifier.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app/features/auth/presentation/screens/check_auth_status_screem.dart';
import 'package:teslo_app/features/auth/presentation/screens/login_screen.dart';
import 'package:teslo_app/features/auth/presentation/screens/register_screen.dart';
import 'package:teslo_app/features/products/presentation/products_screen.dart';
import 'package:teslo_app/features/products/presentation/screen.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: '/splash',
      refreshListenable: goRouterNotifier,
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
        GoRoute(
          path: '/product/:id',
          builder: (context, state) => ProductScreen(
            productId: state.pathParameters['id'] ?? 'no-id',
          ),
        ),
      ],
      redirect: (context, state) {
        final isGoingTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;
        print("estatus $authStatus ruta $isGoingTo");

        if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
          return null;
        }

        if (authStatus == AuthStatus.notAuthenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register') return null;
          return '/login';
        }
        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/splash') {
            return '/';
          }
        }
        return null;
      });
});
