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
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    
final response = await dio.get('/movie/now_playing');
final movieDBResponse = MovieDbResponse.fromJson(response.data);
final List<Movie> movies = movieDBResponse.results
.where((e)=> e.posterPath != 'no-poster')
    .map((e) => MovieMapper.movieDBToEntity(e))
    .toList();

   return movies;
  }
  

  
  


}