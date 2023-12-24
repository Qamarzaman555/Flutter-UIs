import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CHIImageViewer extends StatelessWidget {
  const CHIImageViewer(
      {this.image, this.bytes, required this.imageType, super.key});

  final String? image;
  final Uint8List? bytes;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    File? imageFile;
    if (!kIsWeb) {
      imageFile = File(image!);
    }
    return imageType == ImageType.network
        ? Image.network(image!, fit: BoxFit.cover)
        : kIsWeb
            ? Image.memory(
                bytes!,
                fit: BoxFit.fill,
              )
            : Image.file(imageFile!, fit: BoxFit.cover);
  }
}

enum ImageType { network, local }
