import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/movies/movie.dart';

class Movies extends StatelessWidget {
  const Movies({super.key, required this.list});
  final List<Movie> list;
    // List<Movie>? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Movies'),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.movie_filter_outlined),
          ],
        ),
      ),
      body: ListView.builder(itemBuilder: (context, index) => movieScreenBuilder(context,list[index]),),
    );
  }
}
