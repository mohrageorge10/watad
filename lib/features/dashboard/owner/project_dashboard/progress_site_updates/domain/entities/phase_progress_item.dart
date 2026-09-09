import 'package:flutter/material.dart';

class PhaseProgressItem {
  final String title;
  final int percentage;
  final Color indicatorColor;

  PhaseProgressItem({
    required this.title,
    required this.percentage,
    required this.indicatorColor,
  });
}
