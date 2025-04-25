import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if ((scrollController.position.pixels+200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
        
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Column(
        children: [
          if (widget.title != null && widget.subtitle != null) _Title(widget.title, widget.subtitle),

          Expanded(

            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textSyle =Theme.of(context).textTheme;
    return Container(
      
      margin: const EdgeInsets.symmetric(horizontal: 10),

      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(

              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null){ return GestureDetector(
                    child: FadeIn(child: child),
                    onTap: () {
                      // Navigator.pushNamed(context, MovieScreen.routeName, arguments: movie);
                      context.push('/movie/${movie.id}');
                    },
                  );}
                  return Center(
                    child: CircularProgressIndicator(
                      
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
            
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                movie.title,
                maxLines: 2,
                
                style: textSyle.titleSmall,
              ),
            ),
          ),
          
          Row(
            
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 5),
              Text('${movie.voteAverage}', style: textSyle.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
              const SizedBox(width: 5),
             
              Text(HumanFormat.format(movie.popularity), style: textSyle.bodyMedium?.copyWith(color: const Color.fromARGB(255, 80, 80, 80)),textAlign:TextAlign.right ,),
            ],
          )
          
          ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
