part of 'main_layout_cubit.dart';

abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class MainLayoutChangeTabState extends MainLayoutState {
  final int index;
  MainLayoutChangeTabState(this.index);
}
