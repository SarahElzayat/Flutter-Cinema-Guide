import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/screens/cinemas.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (context, index, realIndex) => Container(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) =>  CinemasScreen())),
              child: Card(
                
                elevation: 20,
                child: Stack(
    
                  alignment: AlignmentDirectional.bottomCenter,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      
                      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 5),
                      color: Colors.grey[300]!.withOpacity(.6),
                      child: Text(
                        
                        'Movie Name',
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            )),
        options: CarouselOptions(
            height: double.infinity,
            scrollPhysics: const BouncingScrollPhysics(),
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical),
      ),
    );
  }
}
