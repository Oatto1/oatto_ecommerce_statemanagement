import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlideApp1 extends StatefulWidget {
  const ImageSlideApp1({super.key});

  @override
  State<ImageSlideApp1> createState() => _ImageSlideApp1State();
}

class _ImageSlideApp1State extends State<ImageSlideApp1> {
  final List<String> imgList = [
    'assets/images/app-1/1.png',
    'assets/images/app-1/2.png',
    'assets/images/app-1/3.png',
    'assets/images/app-1/4.png',
  ];
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      return CarouselSlider(
        options: CarouselOptions(
          height: height,
          // viewportFraction: 1.0,
          enlargeCenterPage: false,

          // autoPlay: false,
        ),
        items: imgList
            .map((item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      height: height,
                    ),
                  )),
                ))
            .toList(),
      );
    });
  }
}
