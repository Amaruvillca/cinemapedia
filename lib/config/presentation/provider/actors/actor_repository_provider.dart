
import 'package:cinemapedia/infrastructure/datasourses/actor_moviedb_datasourse.dart' show ActorMoviedbDatasourse;
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorREpositpryProvider= Provider((ref){

//repositorio inmutable 
  return ActorRepositoryImpl(ActorMoviedbDatasourse());

});