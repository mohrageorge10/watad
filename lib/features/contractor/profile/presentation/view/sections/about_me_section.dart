import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class AboutMeSection extends StatefulWidget {
  final ContractorProfileEntity profile;
  final ValueChanged<String>? onSaveBio;

  const AboutMeSection({
    super.key,
    required this.profile,
    this.onSaveBio,
  });

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.profile.aboutMe);
  }

  @override
  void didUpdateWidget(covariant AboutMeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile.aboutMe != widget.profile.aboutMe && !_isEditing) {
      _controller.text = widget.profile.aboutMe;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _controller.text = widget.profile.aboutMe;
      _isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      _controller.text = widget.profile.aboutMe;
      _isEditing = false;
    });
  }

  void _saveEditing() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSaveBio?.call(text);
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.person_outline_rounded,
      title: 'About Me',
      actionText: _isEditing ? null : 'Editable',
      actionIcon: _isEditing ? null : Icons.edit_outlined,
      onActionTap: _startEditing,
      child: _isEditing
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FA),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    autofocus: true,
                    style: TextStyle(
                      color: const Color(0xFF1D1D1F),
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.r),
                      border: InputBorder.none,
                      hintText: 'Tell us about yourself...',
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _cancelEditing,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF8E8E93),
                      ),
                      child: Text('Cancel', style: TextStyle(fontSize: 12.sp)),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: _saveEditing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white100,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text('Save',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              widget.profile.aboutMe,
              style: TextStyle(
                color: const Color(0xFF1D1D1F),
                fontSize: 13.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }
}
