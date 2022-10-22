import 'package:agency31_app/model/public_api.dart';
import 'package:agency31_app/network/public_api.dart';

class PublicApiController {
  static List<PublicApiModel>? suppliersModel;

  static Future<List<PublicApiModel>?> fetchSuppliersData() async {
    suppliersModel = await PublicApi.data();
    return suppliersModel;
  }
}
