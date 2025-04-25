import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mapper/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasourse extends ActorsDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key':Environment.apiKey,
        'language': 'es-BO',
      }
      
  ));
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    final response = await dio.get('/movie/$movieId/credits');
    

  if (response.statusCode != 200) {
    throw Exception('Error al cargar las peliculas');
  }
  final List<Actor> actors = CreditsResponse.fromJson(response.data)
      .cast
      .where((e) => e.profilePath != null)
      .map((e) => ActorMapper.castToEntity(e)).toList();
    return actors;
  }

}