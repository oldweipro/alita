///需要登录的异常
class NeedLogin extends AlitaNetError {
  NeedLogin({int code = 401, String message = '请先登录'}) : super(code, message);
}

///需要授权的异常
class NeedAuth extends AlitaNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

///网络异常统一格式类
class AlitaNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  AlitaNetError(this.code, this.message, {this.data});
}
