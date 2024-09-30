import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/pages/fighter/model/fighter_model.dart';
import 'package:myapp/pages/fighter/model/techniques_model.dart';
import 'package:myapp/shared/function/apiProvider.dart';

class FightersService {
  Future<List<FighterModel>> ListFighters() async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';

      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final res = await apiProvider.get('api/fighter/');
      List<dynamic> data = res["data"];
      return data.map((item) => FighterModel.fromJson(item)).toList();
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: ' + e.toString());
    }
  }

  Future<List<techniquesModel>> listTechnique() async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final res = await apiProvider.get('api/fighter/technique/');
      List<dynamic> data = res["data"];
      return data.map((item) => techniquesModel.fromJson(item)).toList();
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: ' + e.toString());
    }
  }

  Future<dynamic> ReadFighters(String id) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final data = await apiProvider.get('api/fighter/$id/');
      print('Datos obtenidos: $data');
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> listLevelByIdFighter(String id) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final data = await apiProvider.get('api/fighter/level/$id/');
      print('Datos obtenidos: $data');
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> insertLevelToFighter(
      int id, String techniqueId, int power) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      Map<String, dynamic> body = {"technique_id": techniqueId, "power": power};
      final data = await apiProvider.post('api/fighter/newlevel/$id/', body);
      print('Datos obtenidos: $data');
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> updateLevelToFighter(
      String id, String techniqueId, int fighterId, int power) async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      Map<String, dynamic> body = {
        "technique_id": techniqueId,
        "fighter_id": fighterId,
        "power": power,
      };
      final data = await apiProvider.post('api/level/$id/', body);
      print('Datos obtenidos: $data');
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<categoryModel>> categoryList() async {
    try {
      const String baseUrl =
          'https://22lvmzx4ee.execute-api.us-east-1.amazonaws.com/';
      final ApiProvider apiProvider = ApiProvider(baseUrl: baseUrl);
      final res = await apiProvider.get('api/fighter/category/');
      List<dynamic> data = res["data"];
      return data.map((item) => categoryModel.fromJson(item)).toList();
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: ' + e.toString());
    }
  }
}
