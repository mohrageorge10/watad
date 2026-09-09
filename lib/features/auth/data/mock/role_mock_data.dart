import 'package:watad/core/constants/app_icons.dart';
import 'package:watad/features/auth/data/models/role_model.dart';

class RoleMockData {
  RoleMockData._();

  static const List<RoleModel> roles = [
    RoleModel(
      id: "0",
      title: "Project Owner",
      icon: AppIcons.projectOwner,
      userType: 0,
    ),
    RoleModel(
      id: "1",
      title: "Engineer",
      icon: AppIcons.engineer,
      userType: 1,
    ),
    RoleModel(
      id: "2",
      title: "Contractor",
      icon: AppIcons.contractor,
      userType: 2,
    ),
    RoleModel(
      id: "3",
      title: "Consultant",
      icon: AppIcons.consultant,
      userType: 3,
    ),
    RoleModel(
      id: "4",
      title: "Supplier",
      icon: AppIcons.engineer,
      userType: 4,
    ),
  ];
}
