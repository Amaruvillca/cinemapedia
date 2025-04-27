import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigation extends StatelessWidget {
  const CustomNavigation({super.key});
  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case '/':
        return 0;
      case '/category':
        return 1;
      case '/favorite':
        return 2;
      default:
        return 0;
    }
    // Implement your logic to get the current index
  }

  void navegacion(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/category');
        break;
      case 2:
        context.go('/favorite');
        break;
      default:
        context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),

      onTap: (value) {
        navegacion(context, value);
      },

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
