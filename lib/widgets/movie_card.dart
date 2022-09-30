import 'package:flutter/material.dart';
import '../models/cinema/movie.dart';
import '../screens/movies.dart';

Widget movieCard(BuildContext context, Movie movieObj) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesScreen(movie: movieObj),
          ));
    },
    child: Card(
      color: Colors.black26,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 125,
        padding: const EdgeInsets.all(0),
        child: Row(children: [
          Expanded(
            flex: 8,
            child: Hero(
              tag: movieObj.movieLinkId.toString(),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(movieObj.movieImage ?? ''),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 20,
            child: Container(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(movieObj.movieTitle ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white.withOpacity(.9))),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 15,
                    child: Text(
                      movieObj.movieDescription ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber[700],
                  size: 50,
                ),
                Text(
                  movieObj.movieRating.toString(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          )
        ]),
      ),
    ),
  );
}
