import 'package:get/get.dart';

import '../../app/app_manager.dart';
import '../../modules/auth/controller/auth_controller.dart';
import '../../modules/auth/services/auth_interface.dart';
import '../../modules/auth/services/auth_interface_impl.dart';
import '../../modules/profile/controller/get_profile_controller.dart';
import '../../modules/profile/services/profile_repo.dart';
import '../../modules/profile/services/profile_repo_impl.dart';

void initServices() {
  Get.put<AppManager>(AppManager(), permanent: true);

  Get.put<AuthInterface>(AuthInterfaceImpl(Get.find()));
  Get.put<AuthController>(AuthController(Get.find()), permanent: true);
  Get.lazyPut<ProfilInterface>(
    () => ProfileInterfaceImpl(appPigeon: Get.find()),
  );
  Get.lazyPut<ProfileController>(() => ProfileController());

  // Get.lazyPut<TenderInterface>(() => TenderInterfaceImpl(Get.find()));
  // Get.put(TenderController(Get.find<TenderInterface>()));
  // Get.put<ContributeInterface>(ContributeInterfaceImpl(Get.find()));

  // Get.lazyPut<InformationInterface>(() => InformationInterfaceImpl(Get.find()));

  // Get.lazyPut<PublicMatterInterface>(
  //   () => PublicMatterInterfaceImpl(Get.find()),
  // );
  // Get.put<InformationInterface>(InformationInterfaceImpl(Get.find()));
  // Get.put<NewsController>(NewsController(Get.find()));
  // Get.put(ActivecallsController(Get.find()));
  // Get.put(ElectoralProgressController(ContributeInterfaceImpl(Get.find())));

  // Get.put<RealTimeCommunicationsController>(
  //   RealTimeCommunicationsController(ContributeInterfaceImpl(Get.find())),
  // );
  // Get.lazyPut<NotificationInterface>(
  //   () => NotificationInterfaceImpl(appPigeon: Get.find()),
  // );
  // Get.lazyPut(() => NotificationController(), fenix: true);
}
