import 'dart:ui';

import 'package:cinema_app/screens/web_view_screen.dart';
import 'package:flutter/material.dart';

import '../models/cinema/cinema.dart';

class CinemaView extends StatelessWidget {
  const CinemaView({super.key, required this.cinema});
  final Cinema cinema;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(cinema.cinemaImage.toString()), fit: BoxFit.fill),
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
                    tag: cinema.cinemaLink.toString(),
                    child: Image.network(
                      cinema.cinemaImage!, //['movie_image'],
                      scale: .6,
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cinema.cinemaName.toString(), //['movie_title'],
                    style: Theme.of(context).textTheme.headline3,
                  ),
                 
                  // const SizedBox(
                  //   height: 5,
                  // ),
                 
                  // const SizedBox(
                  //   height: 10,
                  // ),

                  const SizedBox(
                    height: 10,
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
                                  builder: (context) =>
                                      WebViewScreen(cinema.cinemaLink.toString()+'/'),
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
