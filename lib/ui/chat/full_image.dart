import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {
  static const String routeName = '/full-image';
  const FullImage({Key? key, required this.src, required this.tag})
      : super(key: key);
  final String src;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: tag,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1.5,
            child: PhotoView(
              imageProvider: NetworkImage(src),
            ),
          ),
        ),
      ),
    );
  }
}
