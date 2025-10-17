import 'package:get/get.dart';

import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '/network/api_client.dart';
import '/config/api_base_url.dart';

class UserRepostory {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> userApi() async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }
    try {
      final response = await _apiClient.get('${ApiBaseUrl.user}', token.token);
      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_purchase'.tr}: $error");
    }
  }

  Future<dynamic> updateProfile(dynamic data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.put(
        '${ApiBaseUrl.user}${token.userId}/',
        data,
        token.token,
      );
      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_purchase'.tr}: $error");
    }
  }
}
