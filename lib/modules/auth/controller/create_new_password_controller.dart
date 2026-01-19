import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/create_new_password_model.dart';
import '../services/auth_interface.dart';

class ResetPasswordController extends GetxController {
  final String email;
  final String otp;

  ResetPasswordController({required this.email, required this.otp});

  final ProcessStatusNotifier processNotifier =
      ProcessStatusNotifier(initialStatus: DisabledStatus());

  SnackbarNotifier? snackbarNotifier;

  // Password validation states
  RxBool matchOk = false.obs;

  String _newPassword = "";
  String _confirmPassword = "";

  set newPassword(String v) {
    _newPassword = v;
    checkMatch();
  }

  set confirmPassword(String v) {
    _confirmPassword = v;
    checkMatch();
  }

  void checkMatch() {
    matchOk.value = 
      _newPassword.isNotEmpty &&
      _confirmPassword.isNotEmpty &&
      _newPassword == _confirmPassword;

    matchOk.value
        ? processNotifier.setEnabled()
        : processNotifier.setDisabled();
  }

  Future<void> resetPassword(SnackbarNotifier snackbar) async {
    snackbarNotifier = snackbar;

    if (!matchOk.value) {
      processNotifier.setDisabled();
      return;
    }

    processNotifier.setLoading();

    final model = ResetPasswordModel(
      email: email,
      password: _newPassword,
      otp: otp,
    );

    final result =
        await Get.find<AuthInterface>().resetPassword(model);

    handleFold(
      either: result,
      processStatusNotifier: processNotifier,
      successSnackbarNotifier: snackbarNotifier,
      errorSnackbarNotifier: snackbarNotifier,
    );
  }
}
