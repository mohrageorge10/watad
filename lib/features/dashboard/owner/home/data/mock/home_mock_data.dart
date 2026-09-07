import 'package:flutter/material.dart';

enum ProjectStatus { inProgress, designPhase, draft }

class ProjectModel {
  final String title;
  final String location;
  final int progressPercent;
  final ProjectStatus status;

  const ProjectModel({
    required this.title,
    required this.location,
    required this.progressPercent,
    required this.status,
  });
}

class ServiceCategoryModel {
  final String title;
  final String subtitle;
  final IconData icon; // Keep it if needed, or we can ignore it in UI

  const ServiceCategoryModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class HomeMockData {
  static const ProjectModel activeProject = ProjectModel(
    title: "Mountain View Villa",
    location: "New Cairo, Egypt",
    progressPercent: 62,
    status: ProjectStatus.inProgress,
  );

  static const List<ServiceCategoryModel> services = [
    ServiceCategoryModel(
      title: "Find Contractors",
      subtitle: "Browse verified contractors and find the right team for your project.",
      icon: Icons.construction_rounded,
    ),
    ServiceCategoryModel(
      title: "Engineering Offices",
      subtitle: "Discover top engineering offices and review their projects and expertise.",
      icon: Icons.architecture_rounded,
    ),
    ServiceCategoryModel(
      title: "Materials Market",
      subtitle: "Compare prices and order quality construction materials with ease.",
      icon: Icons.storefront_rounded,
    ),
  ];

  static const List<ProjectModel> myProjects = [
    ProjectModel(
      title: "Mountain View Villa",
      location: "New Cairo, Egypt",
      progressPercent: 62,
      status: ProjectStatus.inProgress,
    ),
    ProjectModel(
      title: "Seaside Villa",
      location: "Ain Sokhna, Egypt",
      progressPercent: 25,
      status: ProjectStatus.designPhase,
    ),
    ProjectModel(
      title: "Zayed Residence",
      location: "6th of October, Egypt",
      progressPercent: 10,
      status: ProjectStatus.draft,
    ),
  ];
}
