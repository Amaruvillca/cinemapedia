
import 'package:cinemapedia/config/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/presentation/provider/movies/inicial_loadig_provider.dart';
import 'package:cinemapedia/config/presentation/provider/provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
   

  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(inicialLoadingProvider);
    if (isLoading) return const FullScreenLoading();
    
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final sliderShowMovies = ref.watch(moviesSliderShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    
    return CustomScrollView(

      slivers: [
        const SliverAppBar(
          floating: true,
         
          flexibleSpace: FlexibleSpaceBar(

            title: CustomAppbar(),
            centerTitle: true,
            
          ),
      ),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context,index){
return Column(
         
      
        children: [
          
          MoviesSlider(movies: sliderShowMovies),
          MoviesHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subtitle: 'Lunes 20',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MoviesHorizontalListview(
            movies: upcomingMovies,
            title: 'Poximamente',
            subtitle: 'Este mes',
            loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
          ),
          MoviesHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            subtitle: 'Este mes',
            loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
          ),
          MoviesHorizontalListview(
            movies: topRatedMovies,
            title: 'Mejores valoradas',
            subtitle: 'Este mes',
            loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
          },
          childCount: 1
        ))

      ]
    );
  }
}
