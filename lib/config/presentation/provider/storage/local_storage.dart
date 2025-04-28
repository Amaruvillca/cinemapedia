import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasourses/isar_datasourse.dart';

final localStorageProvider = Provider((ref){
  return LocalStorageRepositoryImpl(IsarDatasourse());

});


