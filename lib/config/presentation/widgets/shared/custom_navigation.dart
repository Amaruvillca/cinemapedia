import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomNavigation({super.key, required  this.currentIndex});
  
  void navigateTo(int index,BuildContext context) {
    // Implement navigation logic here
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        // Navigate to Categories
        context.go('/home/1');
        break;
      case 2:
        // Navigate to Favorites
        context.go('/home/2');
        break;
      default:
      context.go('/home/0');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      
      onTap: (value) {
        navigateTo(value, context);
      },
      currentIndex: currentIndex,
      
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