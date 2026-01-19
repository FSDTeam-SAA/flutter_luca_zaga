// import 'package:flutter/material.dart';
// import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/enter_otp.dart';
// import 'package:flutter_luca_zaga30/modules/onbording/common/textfield.dart';
// import 'package:get/get.dart';
// import '../../../../core/common/widget/reactive_button/save_button.dart';
// import '../../../../core/notifiers/button_status_notifier.dart';
// import '../../../../core/notifiers/snackbar_notifier.dart';
// import '../../../onbording/common/app_logo.dart';
// import '../../../onbording/widgets/background_image.dart';
// import '../../controller/forget_password controller.dart';

// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(
//       ForgetPasswordController(SnackbarNotifier(context: context)),
//     );

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: AuthBackgroundImage(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 0),
//                 const AppLogo(),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Reset Password",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   "Enter your email to receive the OTP",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 SizedBox(height: 40),
//                 LabeledTextField(
//                   controller: controller.emailController,
//                   title: "Email",
//                   hintText: "Enter your email",
//                   prefixIcon: Icons.email_outlined,
//                 ),

//                 const SizedBox(height: 24),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: RSaveButton(
//                     saveText: "Send OTP",
//                     loadingText: "Sending...",
//                     errorText: "Failed",
//                     buttonStatusNotifier: ProcessStatusNotifier(
//                       initialStatus: EnabledStatus(),
//                     ),
//                     onSaveTap: () async {
//                       // await controller.forgetPassword();
//                       Get.to(() => EnterOtp(email: controller.email));
//                     },
//                     onDone: () {
//                       Get.to(() => EnterOtp(email: controller.email));
//                     },
//                     key: null,
//                   ),
//                 ),
//                 SizedBox(height: 70),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/notifiers/button_status_notifier.dart';
import 'package:flutter_luca_zaga30/modules/auth/controller/forget_password%20controller.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/enter_otp.dart';
import 'package:flutter_luca_zaga30/modules/onbording/common/textfield.dart';
import 'package:get/get.dart';

import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../onbording/common/app_logo.dart';
import '../../../onbording/widgets/background_image.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ForgetPasswordController(SnackbarNotifier(context: context)),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                const SizedBox(height: 24),

                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Enter your email to receive the OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 40),

                /// EMAIL FIELD
                LabeledTextField(
                  controller: controller.emailController,
                  title: "Email",
                  hintText: "Enter your email",
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 24),

                /// SEND OTP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RSaveButton(
                    saveText: "Send OTP",
                    loadingText: "Sending...",
                    errorText: "Failed",
                    buttonStatusNotifier: ProcessStatusNotifier(
                      initialStatus: EnabledStatus(),),
                    onSaveTap: () async {
                     Get.to(() => EnterOtp(email: controller.email));
                    },
                    onDone: () {
                      Get.to(() => EnterOtp(email: controller.email));
                    },
                    key: null,
                  ),
                ),

                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
