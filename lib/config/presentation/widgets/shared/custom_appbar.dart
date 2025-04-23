import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
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
            Icon(Icons.movie_filter_outlined, color:colors.primary, size: 27),
            const SizedBox(width: 10),
            Text(
              'Cinemapedia',
              style: textTheme
            ),
            const Spacer(),
IconButton(onPressed: (){}, icon: Icon(Icons.search, color: colors.primary, size: 27)),
            
            
          ],
        ),
      ),
      )
      
      
      );
  }
}