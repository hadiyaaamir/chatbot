import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselSlider extends StatefulWidget {
  const ImageCarouselSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<ImageCarouselSlider> createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.images
              .map((image) => _CarouselImage(image: image))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            disableCenter: true,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: _CarouselCircle(isCurrent: _current == entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CarouselCircle extends StatelessWidget {
  const _CarouselCircle({required this.isCurrent});

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.onPrimary.withOpacity(isCurrent ? 1 : 0.5),
      ),
    );
  }
}

class _CarouselImage extends StatelessWidget {
  const _CarouselImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(image, height: 180, fit: BoxFit.cover),
      ),
    );
  }
}
