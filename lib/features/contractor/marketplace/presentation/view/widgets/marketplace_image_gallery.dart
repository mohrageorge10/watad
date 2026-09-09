import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceImageGallery extends StatefulWidget {
  final List<String> images;

  const MarketplaceImageGallery({
    super.key,
    required this.images,
  });

  @override
  State<MarketplaceImageGallery> createState() =>
      _MarketplaceImageGalleryState();
}

class _MarketplaceImageGalleryState extends State<MarketplaceImageGallery> {
  int _selectedIndex = 0;

  void _openFullGallery(BuildContext context, int initialIndex) {
    showDialog<void>(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (ctx) => _MarketplaceFullGalleryDialog(
        images: widget.images,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final String heroImage = images.isNotEmpty
        ? images[_selectedIndex.clamp(0, images.length - 1)]
        : '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main Hero Image with Badge (tappable to view full screen)
        GestureDetector(
          onTap: () => _openFullGallery(context, _selectedIndex),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: _GalleryNetworkImage(
                    imageUrl: heroImage,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
              Positioned(
                right: 12.w,
                bottom: 12.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xB3000000),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${_selectedIndex + 1}/${images.length}',
                    style: TextStyle(
                      color: AppColors.white100,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        // Thumbnails Row
        if (images.length > 1)
          Row(
            children: [
              for (int i = 0; i < 4 && i < images.length; i++) ...[
                if (i > 0) SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (i == 3 && images.length > 4) {
                        // Tapping the +3 overlay opens full gallery from 4th image
                        _openFullGallery(context, 3);
                      } else {
                        setState(() {
                          _selectedIndex = i;
                        });
                      }
                    },
                    child: _ThumbnailItem(
                      imageUrl: images[i],
                      isSelected: _selectedIndex == i,
                      isLastWithOverlay: i == 3 && images.length > 4,
                      overlayText:
                          '+${images.length - 4 > 0 ? images.length - 4 : 3}',
                    ),
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _ThumbnailItem extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final bool isLastWithOverlay;
  final String overlayText;

  const _ThumbnailItem({
    required this.imageUrl,
    required this.isSelected,
    required this.isLastWithOverlay,
    required this.overlayText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: isSelected
            ? Border.all(color: AppColors.primary, width: 2.w)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isSelected ? 6.r : 8.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _GalleryNetworkImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(8.r),
            ),
            if (isLastWithOverlay)
              Container(
                color: Colors.black.withValues(alpha: 0.6),
                alignment: Alignment.center,
                child: Text(
                  overlayText,
                  style: TextStyle(
                    color: AppColors.white100,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MarketplaceFullGalleryDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _MarketplaceFullGalleryDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_MarketplaceFullGalleryDialog> createState() =>
      _MarketplaceFullGalleryDialogState();
}

class _MarketplaceFullGalleryDialogState
    extends State<_MarketplaceFullGalleryDialog> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.images.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Counter & Close Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_currentIndex + 1} / ${widget.images.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 26.r,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Main Swipeable PageView of All Images
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 3.0,
                    child: Center(
                      child: _GalleryNetworkImage(
                        imageUrl: widget.images[index],
                        borderRadius: BorderRadius.zero,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Thumbnail Strip
            if (widget.images.length > 1)
              Container(
                height: 72.h,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: widget.images.length,
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final isSelected = _currentIndex == index;
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: isSelected
                              ? Border.all(color: AppColors.primary, width: 2.w)
                              : Border.all(color: Colors.white24, width: 1.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: _GalleryNetworkImage(
                            imageUrl: widget.images[index],
                            borderRadius: BorderRadius.circular(6.r),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GalleryNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BorderRadius borderRadius;
  final BoxFit fit;

  const _GalleryNetworkImage({
    required this.imageUrl,
    required this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _fallbackPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFF1E1E1E),
            alignment: Alignment.center,
            child: SizedBox(
              width: 24.r,
              height: 24.r,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          );
        },
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _fallbackPlaceholder(),
      );
    }
    return _fallbackPlaceholder();
  }

  Widget _fallbackPlaceholder() {
    return Container(
      color: const Color(0xFFEDEFFE),
      alignment: Alignment.center,
      child: Icon(
        Icons.villa_rounded,
        color: AppColors.primary,
        size: 28.r,
      ),
    );
  }
}
