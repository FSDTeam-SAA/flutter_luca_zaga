import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/signup_model.dart';
import '../repo/auth_interface.dart';

class SignUpController extends GetxController {
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  SnackbarNotifier? snackbarNotifier;

  final name = ''.obs;
  final email = ''.obs;
  final number = ''.obs;
  final gender = ''.obs;
  final address = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  void setName(String value) {
    name.value = value;
    processNotifier.setEnabled();
  }

  void setEmail(String value) {
    email.value = value;
    processNotifier.setEnabled();
  }

  void setNumber(String value) {
    number.value = value;
    processNotifier.setEnabled();
  }

  void setPassword(String value) {
    password.value = value;
    processNotifier.setEnabled();
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
    processNotifier.setEnabled();
  }

  // --- Build request model ---
  SignupModel get signupModel => SignupModel(
    name: name.value,
    email: email.value,
    password: password.value,
  );

  // --- Signup method ---
  Future<void> signup({
  ProcessStatusNotifier? buttonNotifier,
  SnackbarNotifier? snackbarNotifier,
  VoidCallback? onDone,
}) async {
  buttonNotifier?.setLoading();
  final result = await Get.find<AuthInterface>().signup(signupModel);

  handleFold(
    either: result,
    errorSnackbarNotifier: snackbarNotifier,
    successSnackbarNotifier: snackbarNotifier,
    onError: (failure) {
      buttonNotifier?.setError();
      snackbarNotifier?.notifyError(message: failure.uiMessage);
    },
    onSuccess: (success) {
      buttonNotifier?.setSuccess();

      // Navigate to OTP screen if needed
      // Get.to(() => LoginScreen());
      // snackbarNotifier?.notifySuccess(message: success.);
      onDone?.call();
    },
    processStatusNotifier: buttonNotifier,
    
  );
}

}
