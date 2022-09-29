import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/cinema/movie.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(movie.movieImage.toString()), fit: BoxFit.fill),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
                color: Colors.black //.withOpacity(.5),
                ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Image.network(
                    movie.movieImage.toString(), //['movie_image'],
                    scale: .6,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    movie.movieTitle.toString(), //['movie_title'],
                    style: Theme.of(context).textTheme.headline3,
                  ),

                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[400],
                        size: 35,
                      ),
                      Text(
                        movie.movieRating.toString(),
                        softWrap: false,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  //TODO
                  //add genres

                  const SizedBox(
                    height: 5,
                  ),
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.9),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (context) => ListView.builder(
                          // 5,
                          itemCount: movie.cinema!.length,
                          itemExtent: 50,
                          itemBuilder: (context, index) => MaterialButton(
                            elevation: 2,
                            padding: const EdgeInsets.all(5),
                            onPressed: () {},
                            child: Text(
                              movie.cinema![index].cinemaName.toString(),
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                      );
                    },
                    color: Theme.of(context).primaryColor, //.withOpacity(.5),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Where to watch?',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Wrap(
                    spacing: 5,
                    runSpacing: 8,
                    clipBehavior: Clip.antiAlias,
                    children: List.generate(
                      // 5,
                      movie.movieGenres!.length,
                      (index) => Container(
                        // height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            movie.movieGenres![index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    movie.movieDescription.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
