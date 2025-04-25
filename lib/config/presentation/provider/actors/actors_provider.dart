



import 'package:cinemapedia/config/presentation/provider/actors/actor_repository_provider.dart';

import 'package:cinemapedia/domain/entities/actor.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorByMOviProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String,List<Actor>>>((ref) {
  final getActor = ref.watch(actorREpositpryProvider);
  return ActorsByMovieNotifier(getActor: getActor.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {
  ActorsByMovieNotifier({required this.getActor}):super({});
  final GetActorsCallback getActor;



Future<void> loadActors(String actorId) async{
  

  if(state[actorId] != null) return;
  print("realizando la peticion");

  final List<Actor> actores = await getActor(actorId);
  state = {...state, actorId: actores};
  
}



}