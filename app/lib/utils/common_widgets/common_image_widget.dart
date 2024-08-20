import 'package:cached_network_image/cached_network_image.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:flutter/material.dart';

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({
    super.key,
    required this.imageUrl,
    this.assetImageBoxFit = BoxFit.cover,
    this.networkImageBoxFit = BoxFit.cover,
    this.fallbackAssetImagePath = AppImages.defaultAvatar,
    this.imageHeight,
    this.imageWidth,
    this.progressSize,
  });

  final String imageUrl;
  final String fallbackAssetImagePath;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit networkImageBoxFit;
  final BoxFit assetImageBoxFit;
  final Size? progressSize;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: imageWidth,
      height: imageHeight,
      fit: networkImageBoxFit,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: SizedBox(
          height: progressSize?.height,
          width: progressSize?.width,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            strokeWidth: progressSize != null ? 2 : 4,
          ),
        ),
      ),
      useOldImageOnUrlChange: true,
      errorWidget: (context, url, error) => Image.asset(
        fallbackAssetImagePath,
        width: imageWidth,
        height: imageHeight,
        fit: assetImageBoxFit,
      ),
    );
  }
}
