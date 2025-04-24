import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mapper/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';



class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key':Environment.apiKey,
        'language': 'es-BO',
      }
      
  ));

  List<Movie> _jsonToMovie(Map<String,dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
final List<Movie> movies = movieDBResponse.results
.where((e)=> e.posterPath != 'no-poster')
    .map((e) => MovieMapper.movieDBToEntity(e))
    .toList();

   return movies;
  }
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    
final response = await dio.get('/movie/now_playing',
    queryParameters: {
      'page': page,
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Error al cargar las peliculas');
  }
return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    

    final response = await dio.get('/movie/popular',
    queryParameters: {
      'page': page,
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Error al cargar las peliculas');
  }
return _jsonToMovie(response.data);
    
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
    queryParameters: {
      'page': page,
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Error al cargar las peliculas');
  }
return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
    queryParameters: {
      'page': page,
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Error al cargar las peliculas');
  }
return _jsonToMovie(response.data);
  }
  

  
  


}