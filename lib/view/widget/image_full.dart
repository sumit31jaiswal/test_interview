import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageFull extends StatelessWidget {
  final String file;
  const ImageFull({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: PhotoView(imageProvider: FileImage(File(file)))),
    );
  }
}
