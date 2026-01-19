import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/helpers/validation.dart';
import 'package:get/get.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/login_request_model.dart';
import '../services/auth_interface.dart';

class LoginController extends GetxController {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier(
    initialStatus: DisabledStatus(),
  );
  final SnackbarNotifier snackbarNotifier;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final keepSignedIn = false.obs;
  final isLoading = false.obs;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  LoginController(this.snackbarNotifier);

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      debugPrint("Email: ${emailController.text}");
      email = emailController.text.trim();
    });
    passwordController.addListener(() {
      debugPrint("password: ${passwordController.text}");
      password = passwordController.text.trim();
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  set email(String value) {
    if (value != _email) {
      _email = value;
      canLogin();
    }
  }

  set password(String value) {
    if (value != _password) {
      _password = value;
      canLogin();
    }
  }

  void canLogin() {
    if (_email.isNotEmpty && isEmail(_email) && _password.isNotEmpty) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleKeepSignedIn(bool value) {
    keepSignedIn.value = value;
  }

  Future<void> login({required VoidCallback needVerifyAccount}) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    processStatusNotifier.setLoading();

    try {
      final lr = await Get.find<AuthInterface>().login(
        LoginRequestModel(email: email, password: password),
      );
      handleFold(
        either: lr,
        processStatusNotifier: processStatusNotifier,
        successSnackbarNotifier: snackbarNotifier,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (Success){
          processStatusNotifier.setSuccess();
        },
        onError: (error) {
          if (error.failure == Failure.forbidden) {
            needVerifyAccount();
          } else {
            processStatusNotifier.setError();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
