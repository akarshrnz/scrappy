import 'package:shared_preferences/shared_preferences.dart';


class Header {


  static Map<String, String>  header(SharedPreferences sp) => {
        'Content-type': "application/json",
         "Accept": "*/*",
         "Connection": "keep-alive",
        // 'Authorization': "Bearer ${sp!.getString('token')!}",
        'Authorization': "Bearer ${sp.getString("token")}",
      };
}
