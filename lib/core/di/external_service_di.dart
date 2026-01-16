import 'package:get/get.dart';
import '../constants/api_endpoints.dart';
import '../services/app_pigeon/app_pigeon.dart';
import '../services/app_pigeon/refresh_token_manager.dart';

void externalServiceDI() {
  Get.put(
    AppPigeon(
      RefreshTokenManager(ApiEndpoints.refreshToken),
      baseUrl: ApiEndpoints.baseUrl,
    ),
  );
}
