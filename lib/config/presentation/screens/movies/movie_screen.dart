import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/presentation/provider/provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieId;
  static const String name = 'movie-screen';
  static const String routeName = '/movie/:movieId';
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvi.notifier).loadMovie(widget.movieId);
    ref.read(actorByMOviProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvi)[widget.movieId];
    if (movie == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Center(child: CircularProgressIndicator())],
          ),
        ),
      );
    }
    return Scaffold(body: _CustomSliverApp(movie));
  }
}
final isFavoriteProvider = FutureProvider.family.autoDispose((ref,int movieId)  {
  final local = ref.watch(localStorageProvider);
  final isMovieFavorite = local.isMovieFavorite(movieId);
  return   isMovieFavorite;


});

class _CustomSliverApp extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverApp(this.movie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorites = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,

      slivers: [
        SliverAppBar(
          expandedHeight: size.height * 0.7,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {

                await ref.read(favoriteMOvieProvider.notifier).togggleFavorite(movie);
                ref.invalidate(isFavoriteProvider(movie.id));
                
                

              },
              //icon: const Icon(Icons.favorite_border),
              icon:
              isFavorites.when(
                data: (isFavorite) =>isFavorite
                    ?  const Icon(Icons.favorite_rounded, color: Colors.red)
                    :  const Icon(Icons.favorite_border),
                error: (error, stackTrace) => const  Icon(Icons.error),

                loading: () => const CircularProgressIndicator(strokeWidth: 2,),
              ),

              //const Icon(Icons.favorite_rounded,
                  //color: Colors.red),

            ),
          ],
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true, // Center the title

            background: Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(movie.posterPath, fit: BoxFit.cover,
                  loadingBuilder:
                   (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
                    return SizedBox();

                  },),
                ),

                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.7, 1.0],
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.topLeft,

                        stops: [0.0, 0.3],
                      ),
                    ),
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.topRight,

                        stops: [0.0, 0.3],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          movie.posterPath,
                          width: size.width * 0.3,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: (size.width - 40) * 0.7,
                        child: Column(
                          children: [
                            Text(movie.title, style: theme.titleLarge),
                            const SizedBox(height: 10),
                            Text(
                              movie.overview,
                              style: theme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Release Date: ${movie.releaseDate}',
                              style: theme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //categorias
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    children: [
                      ...movie.genreIds.map(
                        (gender) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Chip(
                            label: Text(gender),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Actores',
                    style: theme.titleLarge,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _ActorMOvie(movieId: movie.id.toString()),
                ),

              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}

class _ActorMOvie extends ConsumerWidget {
  final String movieId;
  const _ActorMOvie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorByMOviProvider);
    if(actors[movieId] == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Actores'),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    final actores = actors[movieId]!;
    return SizedBox(
      height: 300,

      child: ListView.builder(
        itemCount: actores.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actores[index];
          return FadeInRight(
            child: Container(
              width: 135,

              margin: const EdgeInsets.only(right: 10),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(actor.profilePath,
                    height: 180,
                    fit: BoxFit.cover,
                    loadingBuilder:
                    (context, child, loadingProgress) {
                      if (loadingProgress == null) return FadeIn(child: child);
                      return Image.network("https://cdn-icons-png.flaticon.com/512/12225/12225935.png",height: 180,fit: BoxFit.cover,);
                    },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(actor.name,maxLines: 2, textAlign: TextAlign.center ,),

                  Text(actor.character?? "",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis

                    ),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
