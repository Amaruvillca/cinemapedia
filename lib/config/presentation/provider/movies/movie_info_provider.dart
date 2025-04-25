

import 'package:cinemapedia/config/presentation/provider/provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvi = StateNotifierProvider<MovieInfoProvider, Map<String,Movie>>((ref) {
  final getMovie = ref.watch(movieREpositoryProvider);
  return MovieInfoProvider(getMovie: getMovie.getMovieiD);
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieInfoProvider extends StateNotifier<Map<String,Movie>> {
  MovieInfoProvider({required this.getMovie}):super({});
  final GetMovieCallBack getMovie;



Future<void> loadMovie(String movieId) async{
  

  if(state[movieId] != null) return;
  print("realizando la peticion");

  final movie = await getMovie(movieId);
  state = {...state, movieId: movie};
  
}



}