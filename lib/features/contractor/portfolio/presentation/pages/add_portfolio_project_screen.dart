import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_text_field.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';

class AddPortfolioProjectScreen extends StatefulWidget {
  final PortfolioProjectItemModel? project;

  const AddPortfolioProjectScreen({
    super.key,
    this.project,
  });

  @override
  State<AddPortfolioProjectScreen> createState() =>
      _AddPortfolioProjectScreenState();
}

class _AddPortfolioProjectScreenState extends State<AddPortfolioProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _costController;
  late final TextEditingController _dateController;
  late final TextEditingController _mediaUrlController;

  late List<String> _mediaUrls;
  DateTime? _selectedDate;
  bool _isLoading = false;

  bool get isEditMode => widget.project != null;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _titleController = TextEditingController(text: p?.title ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _locationController = TextEditingController(text: p?.location ?? '');
    _costController = TextEditingController(
        text: p?.projectCost != null
            ? p!.projectCost!.toStringAsFixed(0)
            : (p != null ? p.price.replaceAll(RegExp(r'[^0-9]'), '') : ''));
    _dateController = TextEditingController(text: p?.date ?? '');
    _mediaUrlController = TextEditingController();
    _mediaUrls = List<String>.from(p?.allImages ?? []);

    if (_dateController.text.isNotEmpty) {
      try {
        _selectedDate = DateTime.parse(_dateController.text);
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _costController.dispose();
    _dateController.dispose();
    _mediaUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white100,
              onSurface: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _addMediaUrl() {
    final url = _mediaUrlController.text.trim();
    if (url.isNotEmpty && !_mediaUrls.contains(url)) {
      setState(() {
        _mediaUrls.add(url);
        _mediaUrlController.clear();
      });
    }
  }

  void _removeMediaUrl(int index) {
    setState(() {
      _mediaUrls.removeAt(index);
    });
  }

  Future<void> _saveProject(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cost = double.tryParse(_costController.text.trim()) ?? 0.0;
    final dateStr = _dateController.text.trim();

    setState(() {
      _isLoading = true;
    });

    final cubit = sl<PortfolioCubit>();

    String? error;
    if (isEditMode) {
      error = await cubit.updateProject(
        id: widget.project!.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        projectCost: cost,
        completionDate: dateStr,
        mediaUrls: _mediaUrls.isNotEmpty
            ? _mediaUrls
            : ['https://images.unsplash.com/photo-1541888946425-d0fbb186c5f8?w=800&q=80'],
      );
    } else {
      error = await cubit.addProject(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        projectCost: cost,
        completionDate: dateStr,
        mediaUrls: _mediaUrls.isNotEmpty
            ? _mediaUrls
            : ['https://images.unsplash.com/photo-1541888946425-d0fbb186c5f8?w=800&q=80'],
      );
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      AppToast.showError(this.context, error);
    } else {
      AppToast.showSuccess(
        this.context,
        isEditMode
            ? 'Project updated successfully!'
            : 'Project added to portfolio successfully!',
      );
      this.context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white100,
                      size: 20.r,
                    ),
                    splashRadius: 22.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    isEditMode ? 'Edit Project' : 'Add to Portfolio',
                    style: TextStyle(
                      color: AppColors.white100,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Title
              _buildFieldLabel('Project Title *'),
              AppTextField(
                controller: _titleController,
                hintText: 'e.g. Villa Construction Project',
                prefixIcon: const Icon(Icons.business_outlined, color: AppColors.grey500),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter project title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Technical Description
              _buildFieldLabel('Technical Description & Scope *'),
              AppTextField(
                controller: _descriptionController,
                hintText: 'Describe structural scope, finishing materials, and execution highlights...',
                maxLines: 4,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter project description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Location
              _buildFieldLabel('Location *'),
              AppTextField(
                controller: _locationController,
                hintText: 'e.g. New Cairo, Cairo',
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.grey500),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Cost
              _buildFieldLabel('Project Cost (EGP) *'),
              AppTextField(
                controller: _costController,
                hintText: 'e.g. 2500000',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.payments_outlined, color: AppColors.grey500),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter project cost';
                  }
                  if (double.tryParse(val.trim()) == null) {
                    return 'Please enter a valid numeric value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Completion Date
              _buildFieldLabel('Completion Date *'),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12.r),
                child: IgnorePointer(
                  child: AppTextField(
                    controller: _dateController,
                    hintText: 'YYYY-MM-DD',
                    prefixIcon: const Icon(Icons.calendar_today_outlined, color: AppColors.grey500),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.grey600),
                    readOnly: true,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please select completion date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Media / Photos Section
              _buildFieldLabel('Project Media & Photos'),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _mediaUrlController,
                      hintText: 'Paste image URL here...',
                      prefixIcon: const Icon(Icons.image_outlined, color: AppColors.grey500),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: _addMediaUrl,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Icon(Icons.add, color: AppColors.white100, size: 22.r),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // Sample photo shortcut buttons
              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: [
                  _buildQuickPhotoChip(
                    label: '+ Villa Photo',
                    url: 'https://images.unsplash.com/photo-1541888946425-d0fbb186c5f8?w=800&q=80',
                  ),
                  _buildQuickPhotoChip(
                    label: '+ Commercial Photo',
                    url: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&q=80',
                  ),
                  _buildQuickPhotoChip(
                    label: '+ Interior Photo',
                    url: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800&q=80',
                  ),
                ],
              ),

              // Image previews
              if (_mediaUrls.isNotEmpty) ...[
                SizedBox(height: 14.h),
                SizedBox(
                  height: 90.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _mediaUrls.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) {
                      final url = _mediaUrls[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              url,
                              width: 90.w,
                              height: 90.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 90.w,
                                height: 90.h,
                                color: AppColors.grey200,
                                child: Icon(Icons.broken_image, color: AppColors.grey500, size: 28.r),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4.h,
                            right: 4.w,
                            child: InkWell(
                              onTap: () => _removeMediaUrl(index),
                              child: Container(
                                padding: EdgeInsets.all(3.r),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.close, color: Colors.white, size: 14.r),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],

              SizedBox(height: 32.h),

              // Action Button (Must say 'Add to Portfolio' or 'Save Project' as specified)
              AppElevatedButton(
                title: isEditMode ? 'Save Project' : 'Add to Portfolio',
                isLoading: _isLoading,
                onPressed: () => _saveProject(context),
                backgroundColor: AppColors.primary,
                height: 52,
                borderRadius: 14,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuickPhotoChip({required String label, required String url}) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColors.primary.withValues(alpha: 0.08),
      side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      onPressed: () {
        if (!_mediaUrls.contains(url)) {
          setState(() {
            _mediaUrls.add(url);
          });
        }
      },
    );
  }
}
