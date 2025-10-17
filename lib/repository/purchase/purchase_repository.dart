import 'package:get/get.dart';

import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '/network/api_client.dart';
import '/config/api_base_url.dart';

class PurchaseRepository {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> savePurchase(Map<String, dynamic> data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.post(
        ApiBaseUrl.purchase,
        data,
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_purchase'.tr}: $error");
    }
  }

  Future<dynamic> getPurchases() async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.get(ApiBaseUrl.purchase, token.token);
      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_purchase'.tr}: $error");
    }
  }

  Future<dynamic> updatePurchase(Map<String, dynamic> data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.put(
        '${ApiBaseUrl.purchase}${data['id']}/',
        data,
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_purchase'.tr}: $error");
    }
  }

  Future<dynamic> deletePurchase(int id) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.delete(
        '${ApiBaseUrl.purchase}${id}/',
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_delete_purchase'.tr}: $error");
    }
  }
}
