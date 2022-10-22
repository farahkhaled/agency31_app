import 'dart:convert';
import 'dart:developer';
import 'package:agency31_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  static Future<void> sendNotification({
    required String token,
    required String sender,
    required String text,
  }) async {
    try {
      String url = ApiUrl.firebaseNotification;
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        "Authorization":
            "key=AAAAc42zKNE:APA91bGk5tbPvnLF_ZrKT7SNFDSCbqMa4Z-rYdUc5jQ-jjQjTSDgjiPl4aUx5hhrH2ZSNiri5j2foGBR5MoikklFnHGyIuEs8Imtmxrnz3R-2JDB4V020ignJT_KNHCngh7uVeacuDr0",
      };
      log("Response:: PublicApiResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri,
          headers: headers,
          body: jsonEncode(
            {
              "to": token,
              "notification": {
                "title": "you have new message from $sender",
                "body": text,
                "sound": "default"
              },
              "android": {
                "priority": "HIGH",
                "notification": {
                  "notification_priority": "PRIORITY_MAX",
                  "sound": "default",
                  "default_sound": true,
                  "default_vibrate_timings": true,
                  "default_light_settings": true
                }
              },
              "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"}
            },
          ));

      if (response.statusCode == 200) {
        log("message notification sent", name: "notification sent");
      } else {
        log('${response.statusCode}', name: "response statusCode");
        log('${response.body}', name: "response body");
        log('${response.headers}', name: "response header");
        log('${response.reasonPhrase}', name: "response reasonPhrase");
        throw "message notification Error 1";
      }
    } catch (e) {
      log("message notification Error $e");
    }
  }
}
