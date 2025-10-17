import 'package:get/get.dart';

import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '/network/api_client.dart';
import '/config/api_base_url.dart';

class SaleRepository {
  final ApiClient _apiClient = ApiClient();

  /// Save purchase data to API
  Future<Map<String, dynamic>> saveSale(Map<String, dynamic> data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.post(
        ApiBaseUrl.sale,
        data,
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_sale'.tr}: $error");
    }
  }

  Future<dynamic> getSales() async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.get(ApiBaseUrl.sale, token.token);
      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_sale'.tr}: $error");
    }
  }

  Future<dynamic> updateSale(Map<String, dynamic> data) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.put(
        '${ApiBaseUrl.sale}${data['id']}/',
        data,
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_save_sale'.tr}: $error");
    }
  }

  Future<dynamic> deleteSale(int id) async {
    final token = await TokenServicesShareprefrence.getToken();
    if (token == null || token.token.isEmpty) {
      throw Exception("authentication_token_not_found_please_login_again".tr);
    }

    try {
      final response = await _apiClient.delete(
        '${ApiBaseUrl.sale}$id/',
        token.token,
      );

      return response;
    } catch (error) {
      throw Exception("${'failed_to_delete_sale'.tr}: $error");
    }
  }
}
