import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';

class ContractorProfileCubit extends Cubit<ContractorProfileState> {
  final GetContractorProfileUseCase getContractorProfileUseCase;
  final CacheHelper cacheHelper;

  static const String _kCachedProfileImage = 'contractor_cached_profile_image';
  static const String _kCachedName = 'contractor_cached_name';
  static const String _kCachedCompanyName = 'contractor_cached_company_name';
  static const String _kCachedExperience = 'contractor_cached_experience';
  static const String _kCachedAboutMe = 'contractor_cached_about_me';
  static const String _kCachedCommercialRegister = 'contractor_cached_commercial_register';
  static const String _kCachedTaxCard = 'contractor_cached_tax_card';

  ContractorProfileCubit({
    required this.getContractorProfileUseCase,
    required this.cacheHelper,
  }) : super(ContractorProfileInitial());

  Future<void> loadProfile({String? contractorId}) async {
    emit(ContractorProfileLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getContractorProfileUseCase(contractorId: currentId);

    result.fold(
      (profile) {
        if (profile.name.isEmpty && profile.companyName.isEmpty) {
          emit(const ContractorProfileEmpty());
        } else {
          // Merge with any cached overrides
          final mergedProfile = _applyCachedOverrides(profile);
          emit(ContractorProfileSuccess(profile: mergedProfile));
        }
      },
      (failure) {
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

    return profile.copyWith(
      profileImagePath: cachedImage ?? profile.profileImagePath,
      name: cachedName ?? profile.name,
      companyName: cachedCompanyName ?? profile.companyName,
      yearsOfExperience: cachedExperience ?? profile.yearsOfExperience,
      aboutMe: cachedAboutMe ?? profile.aboutMe,
      commercialRegister: cachedCommercialRegister ?? profile.commercialRegister,
      taxCard: cachedTaxCard ?? profile.taxCard,
    );
  }

  void selectTab(int index) {
    if (state is ContractorProfileSuccess) {
      final currentState = state as ContractorProfileSuccess;
      emit(currentState.copyWith(selectedTabIndex: index));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String companyName,
    required String yearsOfExperience,
    required String aboutMe,
    required List<String> specializations,
    required List<String> coveredGovernorates,
    String? commercialRegister,
    String? taxCard,
  }) async {
    if (state is ContractorProfileSuccess) {
      final current = (state as ContractorProfileSuccess).profile;
      final updated = current.copyWith(
        name: name,
        companyName: companyName,
        yearsOfExperience: yearsOfExperience,
        aboutMe: aboutMe,
        specializations: specializations,
        coveredGovernorates: coveredGovernorates,
        commercialRegister: commercialRegister ?? current.commercialRegister,
        taxCard: taxCard ?? current.taxCard,
      );

      // Persist in Cache
      await cacheHelper.saveData(key: _kCachedName, value: name);
      await cacheHelper.saveData(key: _kCachedCompanyName, value: companyName);
      await cacheHelper.saveData(key: _kCachedExperience, value: yearsOfExperience);
      await cacheHelper.saveData(key: _kCachedAboutMe, value: aboutMe);
      if (commercialRegister != null) {
        await cacheHelper.saveData(key: _kCachedCommercialRegister, value: commercialRegister);
      }
      if (taxCard != null) {
        await cacheHelper.saveData(key: _kCachedTaxCard, value: taxCard);
      }

      emit((state as ContractorProfileSuccess).copyWith(profile: updated));
    }
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
