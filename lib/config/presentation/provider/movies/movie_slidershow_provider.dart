

import 'package:cinemapedia/config/presentation/provider/movies/movies_provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSliderShowProvider = Provider<List<Movie>>((ref){

  final movies = ref.watch(nowPlayingMoviesProvider);
  if (movies.isEmpty) {
    return [];
  }
  return movies.sublist(0,6);
});