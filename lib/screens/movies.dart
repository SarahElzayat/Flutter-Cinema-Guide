import 'dart:ui';

import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key, this.movie});
  final movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(movie['movie_image']), fit: BoxFit.fill),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Colors.transparent,
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                  color: Colors.black //.withOpacity(.5),
                  ),
              // margin: EdgeInsets.only( bottom: 20),
              padding: const EdgeInsets.only(
                  // bottom: 20,
                  left: 10,
                  right: 10),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Spacer(),
                    Text(
                      movie['movie_title'],
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
                          movie['movie_rating'].toString(),
                          softWrap: false,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    //TODO
                    //add genres

                    Text(
                      movie['movie_description'],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Wrap(
                        children: List.generate(
                            movie['cinema'].length,
                            (index) => MaterialButton(

                                onPressed: () {},
                                child: Text(
                                    movie['cinema'][index]['cinema_name']))))

                  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
