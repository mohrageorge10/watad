import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadedPhotoItemWidget extends StatelessWidget {
  final String path;
  final VoidCallback? onDelete;

  const UploadedPhotoItemWidget({
    super.key,
    required this.path,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 75.w,
          height: 75.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xFFE5E5EA),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildImageContent(),
        ),

        // Delete Button (x) in top right
        if (onDelete != null)
          Positioned(
            top: 4.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 20.r,
                height: 20.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E3A8A),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 13.r,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    }
    final file = File(path);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    return Container(
      color: const Color(0xFFEDEFFE),
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          color: const Color(0xFF1E3A8A),
          size: 24.r,
        ),
      ),
    );
  }
}
