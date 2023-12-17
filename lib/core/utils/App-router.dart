import 'package:diet_app/screens/auth/landing.screen.dart';
import 'package:diet_app/screens/home/home.screen.dart';
import 'package:diet_app/spalsh/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const KLandingScreen = '/LandingScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: KLandingScreen,
        builder: (context, state) => const LandingScreen(),
      ),
    ],
  );
}
