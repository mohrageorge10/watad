import 'package:watad/core/constants/app_images.dart';
import 'package:watad/features/onboarding/data/models/on_boarding_model.dart';

class OnBoardingMockData {
  static const List<OnBoardingModel> items = [
    OnBoardingModel(
      title: "Preview your home",
      description:
          "See your future home on your land with AR Perspective before construction.",
      imagePath: Assets.imagesOnboarding1,
    ),
    OnBoardingModel(
      title: "Life site watching",
      description:
          "Track daily progress with verified updates, photos, and reports.",
      imagePath: Assets.imagesOnboarding2,
    ),
    OnBoardingModel(
      title: "Smart Budget",
      description:
          "Get a clear project budget and feasibility estimate before you start.",
      imagePath: Assets.imagesOnboarding3,
    ),
    OnBoardingModel(
      title: "AI Design & Code Compliance",
      description:
          "AI architectural designs compliant with the Egyptian Building Code.",
      imagePath: Assets.imagesOnboarding4,
    ),
  ];
}
