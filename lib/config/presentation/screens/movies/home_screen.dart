import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
   static const String name = 'home-screen';
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      
      ),
      body: Center(
        child: Text(
          Environment.apiKey
          
          
        ),
      ),
    );
  }
}