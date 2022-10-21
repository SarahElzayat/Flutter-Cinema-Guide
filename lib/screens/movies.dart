import 'dart:ui';
import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:cinema_app/screens/cinema_view.dart';
import 'package:cinema_app/screens/web_view_screen.dart';
import 'package:flutter/material.dart';
import '../models/cinema/movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late bool isFavorite;
  @override
  void initState() {
    if (AppCubit.get(context).favorites.contains(widget.movie.id)) {
      print('LOLOLOLOY');
      isFavorite = true;
    } else {
      isFavorite = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.movie.movieImage.toString()),
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
                    tag: widget.movie.movieLinkId.toString(),
                    child: Image.network(
                      widget.movie.movieImage!, //['movie_image'],
                      scale: .6,
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.movie.movieTitle.toString(), //['movie_title'],
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
                        widget.movie.movieRating.toString(),
                        softWrap: false,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:20.0),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                itemCount: widget.movie.cinema!.length,
                                itemExtent: 50,
                                itemBuilder: (context, index) => MaterialButton(
                                  elevation: 2,
                                  padding: const EdgeInsets.all(5),
                                  onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CinemaView(
                                            cinema: AppCubit.get(context)
                                                    .cinemasMap[
                                                widget.movie.cinema![index]]!)),
                                  ),
                                  child: Text(
                                    AppCubit.get(context)
                                        .cinemasMap[widget.movie.cinema![index]]!
                                        .cinemaName!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                              ),
                            );
                          },
                          color:
                              Theme.of(context).primaryColor, //.withOpacity(.5),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Where to watch?',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        // Spacer(),
                        IconButton(
                            onPressed: () {
                              if (isFavorite) {
                                AppCubit.get(context)
                                    .deleteData(id: widget.movie.id!);
                              } else {
                                AppCubit.get(context)
                                    .insertIntoDatabase(id: widget.movie.id!);
                              }
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            icon: isFavorite
                                ? const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                  size: 30,
                                )
                                : const Icon(
                                    Icons.favorite_outline_rounded,
                                    color: Colors.grey,
                                    size: 30,
                                  ))
                      ],
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
                      widget.movie.movieGenres!.length,
                      (index) => Container(
                        // height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            widget.movie.movieGenres![index],
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
                    widget.movie.movieDescription.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Spacer(),
                        Expanded(
                          child: MaterialButton(
                            // minWidth: double.infinity,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewScreen(
                                      'https://elcinema.com${widget.movie.movieLinkId}/'),
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
