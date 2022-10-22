import 'dart:convert';
import 'dart:developer';
import 'package:agency31_app/model/public_api.dart';
import 'package:agency31_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class PublicApi {
  static Future<List<PublicApiModel>?> data() async {
    try {
      String url = ApiUrl.makeup;
      Uri uri = Uri.parse(url);
      var headers = {'Content-Type': 'application/json'};
      log("Response:: PublicApiResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("PublicApiStatusCode:: ${response.statusCode}  PublicApiBody:: ${response.body}");
      final list = jsonDecode(response.body) as List;
      // log(list.toString(), name: 'list');
      List<PublicApiModel> modelList = [];
      log(list[0].toString(), name: 'list[0]');
      log(list[1].toString(), name: 'list[1]');
      log(list[2].toString(), name: 'list[2]');
      log(list[3].toString(), name: 'list[3]');
      for (int i = 0; i < list.length; i++) {
        modelList.add(PublicApiModel.fromJson(list[i]));
      }
      // log(modelList.toString());
      log(modelList[0].category.toString(), name: 'modelList[0]');
      log(modelList[1].category.toString(), name: 'modelList[1]');
      log(modelList[2].category.toString(), name: 'modelList[2]');
      log(modelList[3].category.toString(), name: 'modelList[3]');

      // List<PublicApiModel> suppliersModel =
      //     PublicApiModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return modelList;
      } else {
        throw "PublicApi Error";
      }
    } catch (e) {
      log("PublicApi Error $e");
      return null;
    }
  }
}
