import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/signup_model.dart';
import '../services/auth_interface.dart';

class SignUpController extends GetxController {
  final ProcessStatusNotifier processNotifier =
      ProcessStatusNotifier(initialStatus: EnabledStatus());

  // form fields
  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  // setters
  void setName(String v) => name.value = v.trim();
  void setEmail(String v) => email.value = v.trim();
  void setPhone(String v) => phone.value = v.trim();
  void setPassword(String v) => password.value = v.trim();
  void setConfirmPassword(String v) => confirmPassword.value = v.trim();

  SignupModel get signupModel => SignupModel(
        name: name.value,
        email: email.value,
        phone: phone.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
      );

  Future<void> signup({
    required SnackbarNotifier snackbarNotifier,
    VoidCallback? onDone,
  }) async {
    processNotifier.setLoading();

    final result =
        await Get.find<AuthInterface>().signup(signupModel);

    handleFold(
      either: result,
      processStatusNotifier: processNotifier,
      successSnackbarNotifier: snackbarNotifier,
      errorSnackbarNotifier: snackbarNotifier,
      onSuccess: (_) {
        processNotifier.setSuccess();
        onDone?.call();
      },
      onError: (_) {
        processNotifier.setError();
      },
    );
  }
}
