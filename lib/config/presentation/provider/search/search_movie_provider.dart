import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seachQueryMOviesPrivider= StateProvider<String>((ref) => '');
final guardarListaDeBusqueda = StateProvider<List<Movie>>((ref) => []);