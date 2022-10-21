import 'dart:ui';

import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:cinema_app/models/cinema/movie.dart';
import 'package:cinema_app/screens/cinemas.dart';
import 'package:cinema_app/screens/movies.dart';
import 'package:cinema_app/screens/web_view_screen.dart';
import 'package:flutter/material.dart';

import '../models/cinema/cinema.dart';
import 'movies_screen_bgd.dart';

class CinemaView extends StatefulWidget {
  const CinemaView({super.key, required this.cinema});
  final Cinema cinema;

  @override
  State<CinemaView> createState() => _CinemaViewState();
}

class _CinemaViewState extends State<CinemaView> {
  final List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    for (var element in widget.cinema.movies!) {
      _movies.add(AppCubit.get(context).moviesMap[element]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.cinema.cinemaImage.toString()),
            fit: BoxFit.fill),
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
                      child: Hero(
                    tag: widget.cinema.cinemaLink.toString(),
                    child: Image.network(
                      widget.cinema.cinemaImage!, //['movie_image'],
                      scale: .6,
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.cinema.cinemaName.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address : ${widget.cinema.cinemaAddress.toString()}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Movies(
                                  allMoviesList: _movies,
                                ),
                              ),
                            ),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Movies",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewScreen(
                                      '${widget.cinema.cinemaLink}/'),
                                )),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "More Info",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                      ],
                    ),
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
