import 'dart:ui';

import 'package:cinema_app/screens/cinema_view.dart';
import 'package:cinema_app/screens/cinemas.dart';
import 'package:cinema_app/screens/movies.dart';
import 'package:cinema_app/screens/movies_screen_bgd.dart';
import 'package:flutter/material.dart';

import '../models/cinema/cinema.dart';
import '../models/cinema/movie.dart';

Widget moviescrollCard(context, Movie item) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesScreen(movie: item),
          )),
      child: Hero(
        tag: item.movieLinkId.toString(),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
                image: NetworkImage(
                  item.movieImage.toString(),
                  // ['movie_image'],
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2),
                child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                        color: Colors.black.withOpacity(.8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.movieTitle.toString(), //['movie_title'],
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber[400],
                              ),
                              Text(
                                item.movieRating
                                    .toString(), //['movie_rating'].toString(),
                                softWrap: false,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              )),
            ],
          ),
        ),
      ),
    );

Widget showMoreMovies(context, list) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Movies(allMoviesList: list),
          )),
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(.5),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View more',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.arrow_circle_right_outlined,
              ),
            )
          ],
        )),
      ),
    );

Widget saraMovieCard(context, Movie item) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesScreen(movie: item),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          color: Theme.of(context).primaryColor.withOpacity(.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 14,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: item.movieLinkId.toString(),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            item.movieImage.toString(),
                            scale: 1.3,
                          ),
                          placeholder:
                              const AssetImage('assets/images/video.png'),
                        ),
                      )),
                ),
                Expanded(
                  flex: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.movieTitle.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            Text(
                              item.movieRating.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Text(
                          item.movieDescription.toString(),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

Widget cinemasBuilder(context, Cinema item) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CinemaView(cinema: item),
          )),
      child: Hero(
        tag: item.cinemaImage.toString(),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
            image: DecorationImage(
                image: NetworkImage(
                  item.cinemaImage.toString(),
                  // ['movie_image'],
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2),
                child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                        color: Colors.black.withOpacity(.8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Center(
                        child: Text(item.cinemaName.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    )),
              )),
            ],
          ),
        ),
      ),
    );
Widget showMoreCinemas(context, list) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CinemasScreen(cinemas: list),
          )),
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View more',
                style: Theme.of(context).textTheme.headline3,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                ),
              )
            ],
          )),
        ),
      ),
    );
