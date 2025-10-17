import '/network/api_client.dart';
import '/config/api_base_url.dart';

class LoginRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> loginApi(Map<String, dynamic> data) async {
    print(data);
    return await _apiClient.postLogin(ApiBaseUrl.login, data);
  }
}
