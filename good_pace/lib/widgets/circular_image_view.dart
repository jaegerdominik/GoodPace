import 'package:flutter/cupertino.dart';

class CircularImageView extends StatelessWidget {
  const CircularImageView({Key? key, required this.image, required this.size})
      : super(key: key);

  final ImageProvider image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: image,
        ),
      ),
    );
  }
}
