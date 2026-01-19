import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/helpers/auth_role.dart';
import 'package:flutter_luca_zaga30/modules/profile/model/get_profile_model.dart';
import 'package:flutter_luca_zaga30/modules/profile/services/profile_repo.dart';
import 'package:get/get.dart';
import '../../../app/app_manager.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';

class ProfileController extends GetxController {
  final ProfilInterface repo = Get.find<ProfilInterface>();

  final Rxn<ProfileModel> profile = Rxn<ProfileModel>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUserProfile();
  }

  Future<void> getCurrentUserProfile() async {
    final app = Get.find<AppManager>();
    if (app.currentAuthStatus is! Authenticated) {
      debugPrint("User not authenticated");
      return;
    }

    final auth = app.currentAuthStatus as Authenticated;
    final userId = auth.auth.userId;

    isLoading.value = true;

    debugPrint("Fetching profile for user: $userId");

    final result = await repo.getProfile(userId);

    result.fold(
      (failure) {
        debugPrint("PROFILE ERROR: $failure");
      },
      (success) {
        debugPrint("PROFILE LOADED: ${success.data?.name}");
        profile.value = success.data;
      },
    );

    isLoading.value = false;
  }
}
