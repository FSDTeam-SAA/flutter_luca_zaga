import 'package:flutter_luca_zaga30/modules/profile/model/edit_profile_model.dart';
import 'package:flutter_luca_zaga30/modules/profile/model/get_profile_model.dart';
import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/helpers/typedefs.dart';

abstract base class ProfilInterface extends BaseRepository {
  FutureRequest<Success<ProfileModel>> getProfile(String id);
  FutureRequest<Success<ProfileModel>> updateProfile(EditProfileModel param);
}
