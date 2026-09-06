abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState {
  final String route;
  SplashNavigate(this.route);
}