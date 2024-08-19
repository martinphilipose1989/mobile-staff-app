import 'package:app/utils/common_widgets/app_images.dart';
import 'package:flutter/material.dart';

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget(
      {super.key,
      required this.imageUrl,
      this.assetImageBoxFit = BoxFit.cover,
      this.networkImageBoxFit = BoxFit.cover,
      this.fallbackAssetImagePath = AppImages.defaultAvatar,
      this.imageHeight,
      this.imageWidth,
      this.progressSize});

  final String imageUrl;
  final String fallbackAssetImagePath;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit networkImageBoxFit;
  final BoxFit assetImageBoxFit;
  final Size? progressSize;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(fallbackAssetImagePath,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover); // Fallback asset image
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // Return the image when done loading
        }
        return Center(
          child: SizedBox(
            height: progressSize?.height,
            width: progressSize?.width,
            child: CircularProgressIndicator(
              strokeWidth: progressSize != null ? 2 : 4,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      },
    );
  }
}
