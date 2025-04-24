


import 'package:cinemapedia/config/presentation/provider/movies/movies_repository_provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifierProvider,List<Movie>>((ref){
  final fetchMoreMovies = ref.watch(movieREpositoryProvider).getNowPlaying;
return MoviesNotifierProvider(
  fetchMovies:fetchMoreMovies,
);
}); 

final popularMoviesProvider = StateNotifierProvider<MoviesNotifierProvider,List<Movie>>((ref){
  final fetchMoreMovies = ref.watch(movieREpositoryProvider).getPopular;
return MoviesNotifierProvider(
  fetchMovies:fetchMoreMovies,
);
}); 

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifierProvider,List<Movie>>((ref){
  final fetchMoreMovies = ref.watch(movieREpositoryProvider).getUpcoming;
return MoviesNotifierProvider(
  fetchMovies:fetchMoreMovies,
);
}); 

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifierProvider,List<Movie>>((ref){
  final fetchMoreMovies = ref.watch(movieREpositoryProvider).getTopRated;
return MoviesNotifierProvider(
  fetchMovies:fetchMoreMovies,
);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});
class MoviesNotifierProvider extends StateNotifier<List<Movie>>{
int currentPage = 0;
bool isLoading = false;
MovieCallback fetchMovies;
  MoviesNotifierProvider(
    {required this.fetchMovies}
  ):super([]);


Future<void> loadNextPage() async {
  if(isLoading) return;
  print('Loading next page');

  isLoading = true;
  currentPage++;
  final List<Movie> movies = await fetchMovies(page: currentPage);
  state = [...state, ...movies];
  await Future.delayed(const Duration(milliseconds: 300));
  isLoading = false;
}

}