import 'package:go_router/go_router.dart';
import 'package:hackathon2_app/presentation/loading/widgets/screen.dart';
import 'package:hackathon2_app/presentation/home/widgets/screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
