import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/login_screen.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../onbording/common/app_logo.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';
import '../../controller/create_new_password_controller.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  final String otp;

  const ResetPassword({super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    /// Inject controller with email + otp
    final ResetPasswordController controller = Get.put(
      ResetPasswordController(email: email, otp: otp),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 0),
                const AppLogo(),
                Spacer(),
                
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      "Create New Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Password Field
                LabeledTextField(
                  title: "New Password",
                  hintText: "Enter new password",
                  isPassword: true,
                  onChanged: (v) => controller.newPassword = v,
                ),
            
                /// Confirm Password
                LabeledTextField(
                  title: "Confirm Password",
                  hintText: "Confirm new password",
                  isPassword: true,
                  onChanged: (v) => controller.confirmPassword = v,
                ),
            
                const SizedBox(height: 20),
            
                /// Reset Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RSaveButton(
                    saveText: "Continue",
                    loadingText: "Please wait...",
                    doneText: "Password Reset",
                    errorText: "Failed. Try Again",
                    buttonStatusNotifier: controller.processNotifier,
                    onSaveTap: () {
                      controller.resetPassword(
                        controller.snackbarNotifier ??
                            SnackbarNotifier(context: context),
                      );
                    },
                    onDone: () {
                      Get.offAll(() => LoginScreen());
                    },
                    key: null,
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
