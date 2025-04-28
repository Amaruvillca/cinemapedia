



import 'package:cinemapedia/config/presentation/provider/provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMOvieProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int,Movie>>(
  (ref)  {
    final localStorageRepository = ref.watch(localStorageProvider);
    return StorageMoviesNotifier(
      localStorageRepository: localStorageRepository
    );
  }
);
class StorageMoviesNotifier extends StateNotifier<Map<int,Movie>>  {
  int page =0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({
     required this.localStorageRepository
     }):super({});



     Future<List<Movie>> loadNextPage() async {
       final movies = await localStorageRepository.loadMovies(offset: page*10 , limit: 20);
        page++;
        final temporalMap = <int,Movie>{};
        for (final movie in movies) {
          temporalMap[movie.id] = movie;
        }
        state = {...state, ...temporalMap};
        return movies;
     }
     Future<void> togggleFavorite( Movie movie) async {
       await localStorageRepository.toggoFavorite(movie);
       final bool isFavorite = state[movie.id] != null;
       if(isFavorite){
        state.remove(movie.id);
        state = {...state};
       }else{
        state = {...state, movie.id: movie};
       }
     }

}