import 'package:go_router/go_router.dart';
import 'package:cinemapedia/config/presentation/screens/screen_export.dart';

final appRouter = GoRouter(
  initialLocation: HomeScreen.routeName,
  routes: [
GoRoute(
  path: HomeScreen.routeName,
  name: HomeScreen.name,
  builder: (context, state) => const HomeScreen(),
  ),
  
  ]
);