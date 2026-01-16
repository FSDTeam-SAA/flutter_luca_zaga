// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_luca_zaga30/core/helpers/auth_role.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

// import '../core/constants/api_endpoints.dart';
// import '../core/services/app_pigeon/app_pigeon.dart';

// class AppManager extends GetxController {
//   AuthStatus _authStatus = AuthLoading();
//   AuthStatus get currentAuthStatus => _authStatus;

//   final Debouncer authDebouncer = Debouncer(
//     delay: const Duration(milliseconds: 100),
//   );

//   @override
//   void onInit() {
//     super.onInit();
//     _init();
//   }

//   Future<void> _init() async {
//     debugPrint("AppManager initialized");

//     // final initialAuthStatus = await Get.find<AppPigeon>().currentAuth();

//     // ✅ WAIT until UI is ready
//     Get.find<AppPigeon>().authStream.listen((authstatus) {
//       debugPrint("authstatus is::: $authstatus");
//       _decideRoute(authstatus);
//     });
//   }

//   Future<void> _decideRoute(AuthStatus? authStatus) async {
//     if (authStatus is UnAuthenticated) {
//       _authStatus = authStatus;

//       Get.offAll(() => LoginScreen());
//     } else if (authStatus is Authenticated) {
//       debugPrint("Delegating to Homeview");
//       _authStatus = authStatus;

//       await _initializeControllers();

//       if (Get.isRegistered<ProfileController>()) {
//         Get.delete<ProfileController>();
//       }

//       Get.put(ProfileController());

//       Get.offAll(() => AppGround());
//     }

//     update();
//   }

//   Future<void> _initializeControllers() async {
//     if (_authStatus is! Authenticated) return;

//     final userId = (_authStatus as Authenticated).auth.userId;

//     if (userId.isEmpty) return;

//     await Get.find<AppPigeon>().socketInit(
//       SocketConnetParamX(
//         token: null,
//         socketUrl: ApiEndpoints.socketUrl,
//         joinId: userId,
//       ),
//     );

//     Get.find<AppPigeon>().emit("join", userId);
//   }
// }
