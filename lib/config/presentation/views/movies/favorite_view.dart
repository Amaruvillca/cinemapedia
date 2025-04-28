import 'package:cinemapedia/config/presentation/provider/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/config/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNextPage();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    ref.read(favoriteMOvieProvider.notifier).dispose();
    super.dispose();
  }
  void loadNextPage() async {
    if(isLastPage || isLoading) return;
    isLoading = true;
    final movies = await ref.read(favoriteMOvieProvider.notifier).loadNextPage();
    isLoading = false;
    if(movies.isEmpty){
      isLastPage = true;
      
    }

    
  }
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMOvieProvider).values.toList();
    if(favoriteMovies.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 80, color: Colors.red,),
            const SizedBox(height: 10,),
            const Text('No hay favoritos', style: TextStyle(fontSize: 30),),
            const SizedBox(height: 10,),
            FilledButton.tonal(
              onPressed: ()=>context.go('/home/0'),
               child: const Text('Ver peliculas')),
          ],
        ),
      );
    }
    return Scaffold(
      
      body: MovieMasonry(movies: favoriteMovies, loadNextPage: () {
        loadNextPage();
      },)
    );
  }
}