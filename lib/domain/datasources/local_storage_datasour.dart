import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
Future<void> toggoFavorite(Movie movie);
Future<bool> isMovieFavorite(int movieId);
Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}