

import 'package:cinemapedia/config/presentation/views/views.dart';
import 'package:cinemapedia/config/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';




class HomeScreen extends StatelessWidget {
  final int page;
  const HomeScreen({super.key, required this.page});
  static const String name = 'home-screen';
  static const String routeName = '/';
  final viewRouter = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoriteView()
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(body: IndexedStack(
      index: page,
      children: viewRouter,
    ),
    
    bottomNavigationBar: CustomNavigation(currentIndex:page) ,
    );
  }
}

