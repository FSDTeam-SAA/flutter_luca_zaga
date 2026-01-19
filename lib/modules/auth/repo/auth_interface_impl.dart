import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/modules/auth/repo/auth_interface.dart';

import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/helpers/typedefs.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../model/chnage_password_model.dart';
import '../model/create_new_password_model.dart';
import '../model/forget_password_model.dart';
import '../model/login_request_model.dart';
import '../model/signup_model.dart';
import '../model/verify_account_param.dart';

final class AuthInterfaceImpl extends AuthInterface {
  final AppPigeon appPigeon;
  // final OAuthService oAuthService;
  // AuthInterfaceImpl(this.appPigeon, this.oAuthService);
  AuthInterfaceImpl(this.appPigeon);

  Stream<AuthStatus> authStream() {
    return appPigeon.authStream;
  }

  @override
  FutureRequest<Success> login(LoginRequestModel params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.login,
          data: params.toJson(),
        );
        debugPrint("login response: ${response.data}");
        final body = response.data;
        final loginResponse = LoginResponse.fromMap(body);
        await appPigeon.saveNewAuth(
          saveAuthParams: SaveNewAuthParams(
            uid: loginResponse.userId,
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
            data: {
              "userId": loginResponse.userId,
              "name": loginResponse.user.name,
              "email": loginResponse.user.email,
              "role": loginResponse.role,
            },
          ),
        );

        return Success(message: body['message'] ?? 'Login successful');
      },
    );
  }

  @override
  FutureRequest<Success> signup(SignupModel params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.signup,
          data: params.toMap(),
        );

        debugPrint("Signup response: ${response.data}");

        final body = response.data;

        // success returned from server
        return Success(message: body['message'] ?? 'Signup successful');
      },
    );
  }

  @override
  FutureRequest<Success> forgetpassword(ForgetPasswordModel email) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.forgetPassword,
          data: email.toJson(),
        );
        debugPrint("Forget password response: ${response.data}");
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> resetPassword(ResetPasswordModel params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint("Reset password params: ${params.toJson()}");
        final response = await appPigeon.post(
          ApiEndpoints.createNewPassword,
          data: params.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> verifyAccount(VerifyAccountParam params) {
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> verifyCode(param) {
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> changePassword(ChangePasswordModel param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.changePassword,
          data: param.toJson(),
        );
        final body = response.data;
        return Success(message: body['message'] ?? 'Password changed');
      },
    );
  }

  // @override
  // FutureRequest<Success<AuthStatus>> getCurrentAuth() async{
  //   return await asyncTryCatch(tryFunc: ()async{
  //     final authStatus = await appPigeon.currentAuth();
  //     return Success(message: "", data: authStatus);
  //   });
  // }

  @override
  FutureRequest<Success> appleLogin() async {
    // return await asyncTryCatch(tryFunc: () async{
    //   return oAuthService.loginWithGoogle();
    // });
    // TODO: implement appleLogin
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> facebookLogin() async {
    // return await asyncTryCatch(tryFunc: () async{
    //   return oAuthService.loginWithFacebook();
    // });
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> googleLogin() async {
    // return await asyncTryCatch(tryFunc: () async {
    //   return oAuthService.loginWithGoogle();
    // });
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<DataCRUDFailure, Success>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
