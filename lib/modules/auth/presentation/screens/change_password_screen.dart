import 'package:flutter/material.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/theme/text_style.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';
import '../../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordController _changePasswordController;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _changePasswordController = ChangePasswordController(
      SnackbarNotifier(context: context),
    );

    currentPasswordController.addListener(() {
      _changePasswordController.currentPassword = currentPasswordController.text
          .trim();
    });

    newPasswordController.addListener(() {
      _changePasswordController.newPassword = newPasswordController.text.trim();
    });

    confirmNewPasswordController.addListener(() {
      _changePasswordController.confirmPassword = confirmNewPasswordController
          .text
          .trim();
    });
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Change Password',
            style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Current Password
                  LabeledTextField(
                    controller: currentPasswordController,
                    borderRadius: 8,
                    hintText: "Enter your current password",
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: Colors.grey,
                    prefixIconSize: 20,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your current password";
                      }
                      return null;
                    },
                  ),

                  /// New Password
                  LabeledTextField(
                    controller: newPasswordController,
                    borderRadius: 8,
                    hintText: "Enter your new password",
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: Colors.grey,
                    prefixIconSize: 20,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter new password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),

                  /// Confirm Password
                  LabeledTextField(
                    controller: confirmNewPasswordController,
                    borderRadius: 8,
                    hintText: "Confirm your new password",
                    prefixIcon: Icons.lock_outline,
                    prefixIconColor: Colors.grey,
                    prefixIconSize: 20,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  /// Save Button
                  SizedBox(
                    height: 48,
                    child: RSaveButton(
                      width: double.infinity,
                      height: 48,
                      buttonStatusNotifier:
                          _changePasswordController.processNotifier,
                      saveText: "Save",
                      loadingText: "Saving...",
                      doneText: "Done",
                      onDone: () => Navigator.pop(context),
                      onSaveTap: () {
                        if (_formKey.currentState!.validate()) {
                          _changePasswordController.changePassword();
                        }
                      },
                      key: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
