import 'dart:developer';

import 'package:alita/db/alita_cache.dart';
import 'package:alita/http/core/alita_net.dart';
import 'package:alita/http/request/base_request.dart';
import 'package:alita/http/request/login_request.dart';
import 'package:alita/http/request/registration_request.dart';

class LoginDao {
  static const boardingPass = "auth-token";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId ?? "")
        .add("orderId", orderId ?? "");
    var result = await AlitaNet.getInstance().fire(request);
    log(result);
    if (result['code'] == 0 && result['data'] != null) {
      //保存登录令牌
      AlitaCache.getInstance().setString(boardingPass, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return AlitaCache.getInstance().get(boardingPass);
  }
}
