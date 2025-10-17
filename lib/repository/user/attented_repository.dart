import 'package:get/get.dart';

import '../../config/api_base_url.dart';
import '../../network/api_client.dart';
import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';

class AttentedRepository {
  final ApiClient _apiClient = ApiClient();
  Future<dynamic> getAttented(String id) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.get(
        "${ApiBaseUrl.attent}?user_id=$id",
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_sale'.tr}: $error");
    }
  }

  Future<dynamic> createAttented(dynamic data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.post(
        ApiBaseUrl.attent,
        data,
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_sale'.tr}: $error");
    }
  }
}
