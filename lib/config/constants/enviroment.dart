
 import 'package:flutter_dotenv/flutter_dotenv.dart';
 class Environment{
  static String apiKey =dotenv.env['THE_MOVIEDB_KEY'] ?? 'No API Key';

 }

