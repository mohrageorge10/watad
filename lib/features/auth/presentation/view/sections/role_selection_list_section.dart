import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/view/widgets/role_card_widget.dart';

class RoleSelectionListSection extends StatelessWidget {
  const RoleSelectionListSection({
    super.key,
    required this.roles,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  final List<RoleModel> roles;
  final RoleModel? selectedRole;
  final ValueChanged<RoleModel> onRoleSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...roles.map(
          (role) => RoleCardWidget(
            role: role,
            isSelected: selectedRole?.id == role.id,
            onTap: () => onRoleSelected(role),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
