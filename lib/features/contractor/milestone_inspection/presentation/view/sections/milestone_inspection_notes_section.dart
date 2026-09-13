import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MilestoneInspectionNotesSection extends StatefulWidget {
  final String initialNotes;
  final ValueChanged<String> onNotesChanged;

  const MilestoneInspectionNotesSection({
    super.key,
    required this.initialNotes,
    required this.onNotesChanged,
  });

  @override
  State<MilestoneInspectionNotesSection> createState() =>
      _MilestoneInspectionNotesSectionState();
}

class _MilestoneInspectionNotesSectionState
    extends State<MilestoneInspectionNotesSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: 4,
                maxLength: 500,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) =>
                    Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$currentLength/$maxLength',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF8E8E93),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onChanged: widget.onNotesChanged,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF1D1D1F),
                  height: 1.4,
                ),
                decoration: InputDecoration(
                  hintText: 'Add any additional notes about the milestone...',
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFFC7C7CC),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
