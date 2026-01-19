import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/change_password_screen.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/reset_password.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../onbording/common/app_logo.dart';
import '../../../onbording/widgets/background_image.dart';
import '../../controller/verify_account_view_controller.dart';

class EnterOtp extends StatefulWidget {
  final String email;

  const EnterOtp({super.key, required this.email});

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  final Color _brandBlue = AppColors.primarybutton;

  late final VerifyForgetPasswordOtpController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      VerifyForgetPasswordOtpController(
        email: widget.email,
        snackbarNotifier: SnackbarNotifier(context: context),
      ),
      permanent: true,
    );
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _otpControllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    controller.otp = _otp;
  }

  void _onBackspace(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 0),
                          const AppLogo(),
                          Spacer(),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                "Enter security code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Please check your Email for a message with your code. Your code is 6 numbers long.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 40),

                          /// OTP BOXES
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (i) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: i == 5 ? 0 : 12,
                                ),
                                child: SizedBox(
                                  width: 50,
                                  height: 60,
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(skipTraversal: true),
                                    onKey: (e) => _onBackspace(i, e),
                                    child: TextField(
                                      controller: _otpControllers[i],
                                      focusNode: _focusNodes[i],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFDB972C),
                                        contentPadding: EdgeInsets.zero,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: _brandBlue,
                                            width: 1.6,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: _brandBlue,
                                            width: 1.6,
                                          ),
                                        ),
                                      ),
                                      onChanged: (v) => _onChanged(i, v),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 40),

                          /// VERIFY BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: RSaveButton(
                              saveText: "Verify OTP",
                              loadingText: "Verifying...",
                              doneText: "Verified",
                              errorText: "Invalid OTP",
                              key: null,
                              buttonStatusNotifier: controller.processNotifier,
                              onSaveTap: () {
                                controller.verify();
                              },

                              onDone: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPassword(
                                      email: controller.email,
                                      otp: controller.otp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
