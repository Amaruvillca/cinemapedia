

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasourses/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieREpositoryProvider= Provider((ref){

//repositorio inmutable 
  return MovieRepositoryImpl(MoviedbDatasource());

});



