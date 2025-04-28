import 'package:go_router/go_router.dart';
import 'package:cinemapedia/config/presentation/screens/screen_export.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state){
        final page = state.pathParameters['page'] ?? '0';
        return  HomeScreen(page: int.parse(page),);
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
      path: '/',
      redirect: (_, __) {
        return '/home/0';
      },
      )
  ],
);
