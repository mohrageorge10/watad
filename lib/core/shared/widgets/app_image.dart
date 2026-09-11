import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 12,
    this.placeholder,
    this.errorWidget,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  Widget _buildPlaceholder() {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 0.5.w,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.deactivation,
          size: 28.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return placeholder ?? _buildPlaceholder();
    }

    final isAsset = !imageUrl!.startsWith('http://') && !imageUrl!.startsWith('https://');

    Widget imageWidget;
    if (isAsset) {
      imageWidget = Image.asset(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildPlaceholder();
        },
      );
    } else {
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              AppShimmerBox(
                width: width ?? double.infinity,
                height: height ?? 140.h,
                borderRadius: borderRadius,
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildPlaceholder();
        },
      );
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
