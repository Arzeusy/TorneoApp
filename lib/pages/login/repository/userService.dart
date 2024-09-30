import 'package:myapp/shared/function/apiProvider.dart';

class UserService {
  Future<dynamic> login(Map<String, dynamic> body) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';

      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final data = await apiProvider.post('api/user/signin/', body);
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> logOut(Map<String, dynamic> body) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final data = await apiProvider.post('api/user/logout/', body);
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> readUserSession(Map<String, dynamic> body) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final data = await apiProvider.post('api/user/getsession/', body);
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
