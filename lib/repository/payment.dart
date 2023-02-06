import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';



class ZaloPayConfig {
  static const String appId = "2553";
  static const String key1 = "PcY4iZIKFCIdgZvA6ueMcMHHUbRLYjPL";

  static const String appUser = "demo";
  static int transIdDefault = 1;
}

Future<CreateOrderResponse?> createOrderZaloPay(double price) async {
  var header = new Map<String, String>();
  header["Content-Type"] = "application/x-www-form-urlencoded";

  var body = new Map<String, String>();
  body["app_id"] = ZaloPayConfig.appId;
  body["app_user"] = ZaloPayConfig.appUser;
  body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
  body["amount"] = price.toStringAsFixed(0);
  body["app_trans_id"] = getAppTransId();
  body["embed_data"] = "{}";
  body["item"] = "[]";
  body["description"] = getDescription(body["app_trans_id"]!);

  var dataGetMac = sprintf("%s|%s|%s|%s|%s|%s|%s", [
    body["app_id"],
    body["app_trans_id"],
    body["app_user"],
    body["amount"],
    body["app_time"],
    body["embed_data"],
    body["item"]
  ]);
  body["mac"] = getMacCreateOrder(dataGetMac);
  print("mac: ${body["mac"]}");

  http.Response response = await http.post(
    Uri.parse('https://sb-openapi.zalopay.vn/v2/create'),
    headers: header,
    body: body,
  );

  print("body_request: $body");
  if (response.statusCode != 200) {
    return null;
  }

  var data = jsonDecode(response.body);
  print("data_response: $data}");
  return CreateOrderResponse.fromJson(data);
}

String formatDateTime(DateTime dateTime, String layout) {
  return DateFormat(layout).format(dateTime).toString();
}

int transIdDefault = 1;
String getAppTransId() {
  if (transIdDefault >= 100000) {
    transIdDefault = 1;
  }

  transIdDefault += 1;
  var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");
  return sprintf("%s%06d",[timeString, transIdDefault]);
}

String getDescription(String apptransid) => "Thanh toán cho đơn hàng  #$apptransid";

String getMacCreateOrder(String data) {
  var hmac =  new Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
  return hmac.convert(utf8.encode(data)).toString();
}
class CreateOrderResponse {
  final String zptranstoken;
  final String orderurl;
  final int returncode;
  final String returnmessage;
  final int subreturncode;
  final String subreturnmessage;
  final String ordertoken;
  
  CreateOrderResponse(
      {required this.zptranstoken, required this.orderurl, required this.returncode, required this.returnmessage, required this.subreturncode, required this.subreturnmessage, required this.ordertoken});

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      zptranstoken: json['zp_trans_token'] as String,
      orderurl: json['order_url'] as String,
      returncode: json['return_code'] as int,
      returnmessage: json['return_message'] as String,
      subreturncode: json['sub_return_code'] as int,
      subreturnmessage: json['sub_return_message'] as String,
      ordertoken: json["order_token"] as String,
    );
  }
}