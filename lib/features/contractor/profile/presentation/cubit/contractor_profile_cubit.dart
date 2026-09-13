import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/profile/data/models/review_model.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_reviews_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/update_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';

class ContractorProfileCubit extends Cubit<ContractorProfileState> {
  final GetContractorProfileUseCase getContractorProfileUseCase;
  final UpdateContractorProfileUseCase? updateContractorProfileUseCase;
  final GetContractorReviewsUseCase? getContractorReviewsUseCase;
  final CacheHelper cacheHelper;

  static const String _kCachedProfileImage = 'contractor_cached_profile_image';
  static const String _kCachedName = 'contractor_cached_name';
  static const String _kCachedCompanyName = 'contractor_cached_company_name';
  static const String _kCachedExperience = 'contractor_cached_experience';
  static const String _kCachedAboutMe = 'contractor_cached_about_me';
  static const String _kCachedSpecializations = 'contractor_cached_specializations';
  static const String _kCachedGovernorates = 'contractor_cached_governorates';
  static const String _kCachedCommercialRegister = 'contractor_cached_commercial_register';
  static const String _kCachedTaxCard = 'contractor_cached_tax_card';
  static const String _kCachedPortfolioProjects = 'contractor_cached_portfolio_projects';

  ContractorProfileCubit({
    required this.getContractorProfileUseCase,
    this.updateContractorProfileUseCase,
    this.getContractorReviewsUseCase,
    required this.cacheHelper,
  }) : super(ContractorProfileInitial());

  Future<void> loadProfile({String? contractorId}) async {
    emit(ContractorProfileLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getContractorProfileUseCase(contractorId: currentId);

    if (isClosed) return;
    await result.fold(
      (profile) async {
        if (isClosed) return;
        // Merge with any cached overrides first
        final mergedProfile = _applyCachedOverrides(profile);

        if (mergedProfile.name.isEmpty && mergedProfile.companyName.isEmpty) {
          emit(const ContractorProfileEmpty());
        } else {
          List<ReviewModel> reviews = const [];
          if (getContractorReviewsUseCase != null) {
            final reviewsResult = await getContractorReviewsUseCase!();
            reviews = reviewsResult.fold((data) => data, (_) => const []);
          }

          if (isClosed) return;
          emit(ContractorProfileSuccess(
            profile: mergedProfile,
            reviews: reviews,
          ));
        }
      },
      (failure) async {
        if (isClosed) return;
        emit(ContractorProfileError(failure.errMessage));
      },
    );
  }

  ContractorProfileEntity _applyCachedOverrides(ContractorProfileEntity profile) {
    final cachedImage = cacheHelper.getData(key: _kCachedProfileImage) as String?;
    final cachedName = cacheHelper.getData(key: _kCachedName) as String?;
    final cachedCompanyName = cacheHelper.getData(key: _kCachedCompanyName) as String?;
    final cachedExperience = cacheHelper.getData(key: _kCachedExperience) as String?;
    final cachedAboutMe = cacheHelper.getData(key: _kCachedAboutMe) as String?;
    final cachedCommercialRegister = cacheHelper.getData(key: _kCachedCommercialRegister) as String?;
    final cachedTaxCard = cacheHelper.getData(key: _kCachedTaxCard) as String?;
    final cachedSpecializationsRaw = cacheHelper.getData(key: _kCachedSpecializations) as String?;
    final cachedGovernoratesRaw = cacheHelper.getData(key: _kCachedGovernorates) as String?;
    final cachedPortfolioProjectsRaw = cacheHelper.getData(key: _kCachedPortfolioProjects) as String?;

    List<String>? cachedSpecializations;
    if (cachedSpecializationsRaw != null && cachedSpecializationsRaw.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedSpecializationsRaw);
        if (decoded is List) {
          cachedSpecializations = decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    }

    List<String>? cachedGovernorates;
    if (cachedGovernoratesRaw != null && cachedGovernoratesRaw.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedGovernoratesRaw);
        if (decoded is List) {
          cachedGovernorates = decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    }

    List<PortfolioProjectItemModel> cachedProjects = [];
    if (cachedPortfolioProjectsRaw != null && cachedPortfolioProjectsRaw.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedPortfolioProjectsRaw);
        if (decoded is List) {
          cachedProjects = decoded
              .map((e) => PortfolioProjectItemModel.fromJson(
                  Map<String, dynamic>.from(e)))
              .toList();
        }
      } catch (_) {}
    }

    final mergedPortfolioProjects = [
      ...cachedProjects,
      ...profile.portfolioProjects.where((p) => !cachedProjects.any((cp) =>
          cp.id == p.id ||
          cp.title.toLowerCase().trim() == p.title.toLowerCase().trim())),
    ];

    final rawAboutMe = cachedAboutMe ?? profile.aboutMe;
    final cleanAboutMe = (rawAboutMe.contains('Tap Edit Profile') ||
            rawAboutMe.contains('Specializing in'))
        ? ''
        : rawAboutMe;

    final rawCompanyName = cachedCompanyName ?? profile.companyName;
    final cleanCompanyName =
        rawCompanyName == 'Company Details Pending' ? '' : rawCompanyName;

    final rawExperience = cachedExperience ?? profile.yearsOfExperience;
    final cleanExperience = (rawExperience == '0' || rawExperience == '15')
        ? (cachedExperience != null && cachedExperience != '15' ? cachedExperience : '')
        : rawExperience;

    return profile.copyWith(
      profileImagePath: cachedImage ?? profile.profileImagePath,
      name: cachedName ?? profile.name,
      companyName: cleanCompanyName,
      yearsOfExperience: cleanExperience,
      aboutMe: cleanAboutMe,
      specializations: cachedSpecializations ?? profile.specializations,
      coveredGovernorates: cachedGovernorates ?? profile.coveredGovernorates,
      commercialRegister: cachedCommercialRegister ?? profile.commercialRegister,
      taxCard: cachedTaxCard ?? profile.taxCard,
      portfolioProjects: mergedPortfolioProjects,
      projectsCompiled: mergedPortfolioProjects.isNotEmpty
          ? mergedPortfolioProjects.length.toString()
          : profile.projectsCompiled,
    );
  }

  void selectTab(int index) {
    if (state is ContractorProfileSuccess) {
      final currentState = state as ContractorProfileSuccess;
      emit(currentState.copyWith(selectedTabIndex: index));
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String companyName,
    required String yearsOfExperience,
    required String aboutMe,
    required List<String> specializations,
    required List<String> coveredGovernorates,
    String? commercialRegister,
    String? taxCard,
  }) async {
    // 1. Prepare typed payload according to API specifications
    final int expInt = int.tryParse(yearsOfExperience.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final String govStr = coveredGovernorates.join(', ');
    final String specStr = specializations.isNotEmpty ? specializations.first : '';

    final Map<String, dynamic> profileData = {
      'companyName': companyName,
      'commercialRegister': commercialRegister ?? '',
      'taxCard': taxCard ?? '',
      'bio': aboutMe,
      'specialization': specStr,
      'coveredGovernorates': govStr,
      'yearsOfExperience': expInt,
    };

    // 2. Call API via UseCase if available
    if (updateContractorProfileUseCase != null) {
      final result = await updateContractorProfileUseCase!(profileData: profileData);
      String? errorMessage;
      result.fold(
        (_) => null,
        (failure) => errorMessage = failure.errMessage,
      );

      if (errorMessage != null) {
        return errorMessage;
      }
    }

    // 3. Persist in Cache
    await cacheHelper.saveData(key: _kCachedName, value: name);
    await cacheHelper.saveData(key: _kCachedCompanyName, value: companyName);
    await cacheHelper.saveData(key: _kCachedExperience, value: yearsOfExperience);
    await cacheHelper.saveData(key: _kCachedAboutMe, value: aboutMe);
    await cacheHelper.saveData(key: _kCachedSpecializations, value: jsonEncode(specializations));
    await cacheHelper.saveData(key: _kCachedGovernorates, value: jsonEncode(coveredGovernorates));
    if (commercialRegister != null) {
      await cacheHelper.saveData(key: _kCachedCommercialRegister, value: commercialRegister);
    }
    if (taxCard != null) {
      await cacheHelper.saveData(key: _kCachedTaxCard, value: taxCard);
    }
    await cacheHelper.saveData(key: 'contractor_is_profile_complete', value: true);

    // 4. Update local state upon successful update
    final currentProfile = (state is ContractorProfileSuccess)
        ? (state as ContractorProfileSuccess).profile
        : const ContractorProfileEntity(
            id: '',
            name: '',
            companyName: '',
            rating: 0.0,
            reviewsCount: 0,
            isVerified: false,
            yearsOfExperience: '0',
            projectsCompiled: '0',
            verificationStatus: 'Unverified',
            commercialRegister: '',
            taxCard: '',
            aboutMe: '',
            specializations: [],
            coveredGovernorates: [],
            portfolioImages: [],
          );

    final updated = currentProfile.copyWith(
      name: name,
      companyName: companyName,
      yearsOfExperience: yearsOfExperience,
      aboutMe: aboutMe,
      specializations: specializations,
      coveredGovernorates: coveredGovernorates,
      commercialRegister: commercialRegister ?? currentProfile.commercialRegister,
      taxCard: taxCard ?? currentProfile.taxCard,
      isCompleted: true,
    );

    List<ReviewModel> reviews = const [];
    int selectedTabIndex = 0;
    if (state is ContractorProfileSuccess) {
      final currentState = state as ContractorProfileSuccess;
      reviews = currentState.reviews;
      selectedTabIndex = currentState.selectedTabIndex;
    }

    emit(ContractorProfileSuccess(
      profile: updated,
      reviews: reviews,
      selectedTabIndex: selectedTabIndex,
    ));

    return null; // Null indicates success
  }

  Future<void> updateProfileImage(String imagePath) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final updated = current.copyWith(profileImagePath: imagePath);
      await cacheHelper.saveData(key: _kCachedProfileImage, value: imagePath);
      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
  }

  Future<void> removeProfileImage() async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final updated = current.copyWith(clearProfileImage: true);
      await cacheHelper.removeData(key: _kCachedProfileImage);
      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
  }

  Future<void> updateAboutMe(String newAboutMe) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final updated = current.copyWith(aboutMe: newAboutMe);
      await cacheHelper.saveData(key: _kCachedAboutMe, value: newAboutMe);
      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
  }

  Future<void> addSpecialization(String item) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      if (!current.specializations.contains(item)) {
        final list = List<String>.from(current.specializations)..add(item);
        final updated = current.copyWith(specializations: list);
        emit((state as ContractorProfileSuccess).copyWith(profile: updated));
      }
    }
  }

  Future<void> removeSpecialization(String item) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final list = List<String>.from(current.specializations)..remove(item);
      final updated = current.copyWith(specializations: list);
      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
  }

  Future<void> addCoveredGovernorate(String city) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      if (!current.coveredGovernorates.contains(city)) {
        final list = List<String>.from(current.coveredGovernorates)..add(city);
        final updated = current.copyWith(coveredGovernorates: list);
        emit((state as ContractorProfileSuccess).copyWith(profile: updated));
      }
    }
  }

  Future<void> removeCoveredGovernorate(String city) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final list = List<String>.from(current.coveredGovernorates)..remove(city);
      final updated = current.copyWith(coveredGovernorates: list);
      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
  }
}
