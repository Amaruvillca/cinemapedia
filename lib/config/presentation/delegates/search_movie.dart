import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/presentation/provider/search/search_movie_provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


typedef SeachMOviesCallback = Future<List<Movie>> Function(String query);


class SearchMovie extends SearchDelegate<Movie?> {

  final SeachMOviesCallback seachMovie;
   List<Movie> moviesList ;
  final WidgetRef ref;
  final StreamController<List<Movie>> debounceMovie = StreamController.broadcast();
  Timer? _debounceTimer;
  final bool isLoading = false;
  void clearStream() {
    debounceMovie.close();
  }
  void _onQueryChanged(String query) {
    print("query cambio");
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      print("busqueda realizada");
      if (query.isEmpty) {
        debounceMovie.add([]);
        return;
      }
      final movies = await seachMovie(query);
      debounceMovie.add(movies);
      //actualizar el provider de busqueda
      ref.read(seachQueryMOviesPrivider.notifier).update((state) => query);
      ref.read(guardarListaDeBusqueda.notifier).update((state) => []);

      ref.read(guardarListaDeBusqueda.notifier).update((state) => movies);
      moviesList = movies;



    });
  }

  SearchMovie( {
    super.searchFieldLabel, 
    super.searchFieldStyle, 
    super.searchFieldDecorationTheme, 
    super.keyboardType, 
    super.textInputAction,
     super.autocorrect, 
     super.enableSuggestions, 
     required this.seachMovie,
     required this.ref,
     required this.moviesList
  });
  @override
  String get searchFieldLabel => 'Buscar Peliculas';
  //constrir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            ref.read(seachQueryMOviesPrivider.notifier).update((state) => '');
            ref.read(guardarListaDeBusqueda.notifier).update((state) => []);
            query = '';
            //clearStream();
          },
        ),
      ),
      
    ];
  }
  Widget builResulSearch(){
    return StreamBuilder(
      //future: seachMovie(query), 
      initialData: moviesList,
      stream: debounceMovie.stream,
      builder: (context,snapshot){
        
        final movies = snapshot.data ?? [];
        //ref.read(guardarListaDeBusqueda.notifier).update((state) => []);
        
        if(movies.isEmpty ){
          return const Center(
            child: Text('No se encontraron resultados'),
          );
        }
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return ListTile(

              
              leading: FadeInLeft(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(movie.posterPath, width: 50, height: 70, fit: BoxFit.cover,
                  
                  ),
                  
                ),
              ),
              title: Text(movie.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.overview.length > 100 ? '${movie.overview.substring(0, 100)}...' : movie.overview),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 15, color: Color.fromARGB(255, 168, 153, 12)),
                      const SizedBox(width: 5),
                      Text('${movie.voteAverage}', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.calendar_month, size: 15),
                      const SizedBox(width: 5),
                      Text(movie.releaseDate.toString().substring(0, 10), style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              onTap: () {
                context.push('/home/0/movie/${movie.id}');
              },
            );
          },
         
        );
      }
      
      );

  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return builResulSearch();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    // TODO: implement buildSuggestions
    return builResulSearch();
  }
}
