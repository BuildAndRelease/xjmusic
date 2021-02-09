import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 圆形头像
class Avatar extends StatelessWidget {
  final String url;
  final double radius;
  final File file;
  final Key widgetKey;

  const Avatar({this.url, this.file, this.radius = 15, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    final innerBorder = BoxDecoration(
      border: Border.all(
          color: Theme.of(context).disabledColor.withOpacity(0.3), width: 0.5),
      shape: BoxShape.circle,
    );
    if (file == null && (url == null || url == '')) return const SizedBox();
    if (file != null)
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
          shape: BoxShape.circle,
        ),
        foregroundDecoration: innerBorder,
      );
    return CachedNetworkImage(
      key: widgetKey,
      fadeInDuration: Duration.zero,
      imageUrl: url,
      width: radius * 2,
      height: radius * 2,
      imageBuilder: (_, image) {
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover),
            shape: BoxShape.circle,
          ),
          foregroundDecoration: innerBorder,
        );
      },
      placeholder: (_, __) {
        return Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFf0f1f2),
            shape: BoxShape.circle,
          ),
          foregroundDecoration: innerBorder,
          width: radius * 2,
          height: radius * 2,
        );
      },
    );
  }
}
