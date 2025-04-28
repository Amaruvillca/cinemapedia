import 'package:cinemapedia/domain/datasources/local_storage_datasour.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasourse extends LocalStorageDatasource {
  late Future<Isar> db;
  
  IsarDatasourse() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        
        inspector: true,
      );
    } else {
      return Future.value(Isar.getInstance());
    }
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    // TODO: implement isMovieFavorite
    final isar = await db;
    final Movie? isFavorite =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    // TODO: implement loadMovies
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggoFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMOvie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMOvie != null) {
      print('Eliminando de favoritos');
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMOvie.isarId!));
      return;
    } else {
      print('Agregando a favoritos');
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
