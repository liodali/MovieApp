import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:movie_app/app/common/app_localization.dart';

class MovieImage extends StatelessWidget {
  final String url;
  final Size? size;
  final BoxFit? fit;
  final Widget? errorWidget;

  const MovieImage({
    Key? key,
    required this.url,
    this.size,
    this.fit,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final server = FlutterConfig.get("IMAGE_SERVER");
    return CachedNetworkImage(
      imageUrl: "$server/$url",
      maxHeightDiskCache: 100,
      maxWidthDiskCache: 100,
      height: size?.height,
      width: size?.width,
      filterQuality: FilterQuality.high,
      fit: fit,
      errorWidget: (ctx, x, p) {
        return Center(
          child: errorWidget ??
              Text(
                MyAppLocalizations.of(context)!.errorLoadImage,
              ),
        );
      },
    );
  }
}
