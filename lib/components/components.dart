import 'dart:ui';

import 'package:cinema_app/screens/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget movieBuilder(context, item) => InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  MoviesScreen(movie: item),
          )),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          image: DecorationImage(
              image: NetworkImage(
                item['movie_image'],
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
                      color: Colors.black.withOpacity(.5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['movie_title'],
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
                              item['movie_rating'].toString(),
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
    );
