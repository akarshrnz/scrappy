import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Header {
  // static Map<String, String> get header => {
  // "Content-Type": "application/json",
  // "Connection": "keep-alive",
  // "Accept-Encoding": "gzip, deflate",
  // "User-Agent": "Fetch Client",
  // "Accept": "*/*",
  // "Cache-Control": "no-cache",
  // 'Authorization': "Bearer ${sp!.getString('token')!}"
  //     };

  // static Map<String, String> get loginHeader => {
  //       "Content-Type": "application/json",
  //       "Connection": "keep-alive",
  //       "Accept-Encoding": "gzip, deflate",
  //       "User-Agent": "Fetch Client",
  //       "Accept": "*/*",
  //       "Cache-Control": "no-cache",
  //     };

  static Map<String, String>  header(SharedPreferences sp) => {
        'Content-type': "application/json",
        // 'Authorization': "Bearer ${sp!.getString('token')!}",
        'Authorization': "Bearer ${sp.getString("token")}",
      };
}
