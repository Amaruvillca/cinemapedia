
import 'package:cinemapedia/config/presentation/provider/provider.dart';
import 'package:cinemapedia/config/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String name = 'home-screen';
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // cambia según el fondo
      ),
    );
    return Scaffold(body: _HomeView(),
    
    bottomNavigationBar: CustomNavigation() ,
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final sliderShowMovies = ref.watch(moviesSliderShowProvider);
    
    return Column(
       

      children: [
        CustomAppbar(),
        MoviesSlider(movies: sliderShowMovies),
        MoviesHorizontalListview(
          movies: ref.watch(nowPlayingMoviesProvider),
          title: 'En cines',
          subtitle: 'Lunes 20',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
        ),
      ],
    );
  }
}
