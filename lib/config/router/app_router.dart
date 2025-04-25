import 'package:go_router/go_router.dart';
import 'package:cinemapedia/config/presentation/screens/screen_export.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomeScreen.routeName,
  routes: [
GoRoute(
  path: HomeScreen.routeName,
  name: HomeScreen.name,
  builder: (context, state) => const HomeScreen(),
  routes: [
    GoRoute(
  path: MovieScreen.routeName,
  name: MovieScreen.name,
  builder: (context, state) {
    final movieId = state.pathParameters['movieId']?? '0';

    return MovieScreen(movieId: movieId);}
  ),

  ]
    
  ),

  

  
  
  ]
);