import 'dart:io';

import 'package:flutter/material.dart';

class SingleImageView extends StatelessWidget {
  final File file;
  const SingleImageView({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Image.file(file),
    );
  }
}
