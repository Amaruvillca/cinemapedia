

import 'package:cinemapedia/domain/datasources/movies_datasources.dart' show MoviesDatasource;
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    

    return datasource.getNowPlaying(page: page);
    
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    // TODO: implement getPopular
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    // TODO: implement getTopRated
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    // TODO: implement getUpcoming
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieiD(String id) {
    // TODO: implement getMovieiD
    return datasource.getMovieiD(id);
  }
  
  @override
  Future<List<Movie>> setarchMovie(String query) {
    // TODO: implement setarchMovie
    return datasource.setarchMovie(query);
  }

}