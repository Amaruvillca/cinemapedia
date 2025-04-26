import 'package:cinemapedia/config/presentation/delegates/search_movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/presentation/provider/provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_filter_outlined,
                color: colors.primary,
                size: 27,
              ),
              const SizedBox(width: 10),
              Text('Cinemapedia', style: textTheme),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final moviesRepository = ref.read(movieREpositoryProvider);
                  final query = ref.read(seachQueryMOviesPrivider);
                  final moviesList = ref.read(guardarListaDeBusqueda);

                  showSearch(context: context, delegate: SearchMovie(

                    seachMovie: moviesRepository.setarchMovie,
                    ref: ref,
                    moviesList: moviesList,
                     
                  ),
                  query: query,

                  
                    );
                },
                icon: Icon(Icons.search, color: colors.primary, size: 27),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
