import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselSlider extends StatelessWidget {
  const ImageCarouselSlider({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (image) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(image, height: 180, fit: BoxFit.cover),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
      ),
    );
  }
}
