

import 'package:cinemapedia/config/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';




class HomeScreen extends StatelessWidget {

  final Widget childView;
  const HomeScreen({super.key, required this.childView});
  static const String name = 'home-screen';
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:childView,
    
    bottomNavigationBar: CustomNavigation() ,
    );
  }
}

