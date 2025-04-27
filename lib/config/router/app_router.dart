import 'package:cinemapedia/config/presentation/views/views.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/config/presentation/screens/screen_export.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomeScreen.routeName,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: HomeScreen.routeName,
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
        GoRoute(
          path: MovieScreen.routeName,
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['movieId'] ?? '0';

            return MovieScreen(movieId: movieId);
          },
        ),
      ],
        ),
        GoRoute(
          path: '/favorite',
          builder: (context, state) {
            return const FavoriteView();
          },
        ),
      ],
    ),

    // GoRoute(
    //   path: HomeScreen.routeName,
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: HomeView()),
    //   routes: [
    //     GoRoute(
    //       path: MovieScreen.routeName,
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['movieId'] ?? '0';

    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
