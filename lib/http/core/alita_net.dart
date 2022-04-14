import 'package:alita/http/core/alita_error.dart';
import 'package:alita/http/core/alita_interceptor.dart';
import 'package:alita/http/core/alita_net_adapter.dart';
import 'package:alita/http/core/dio_adapter.dart';
import 'package:alita/http/request/base_request.dart';

class AlitaNet {
  AlitaNet._();

  AlitaErrorInterceptor? _alitaErrorInterceptor;
  static AlitaNet? _instance;

  static AlitaNet getInstance() {
    _instance ??= AlitaNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    AlitaNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on AlitaNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    var alitaError;
    switch (status) {
      case 200:
        return result;
      case 401:
        alitaError = NeedLogin();
        break;
      case 403:
        alitaError = NeedAuth(result.toString(), data: result);
        break;
      default:
        //如果error不为空，则复用现有的error
        alitaError = error ??
            AlitaNetError(status ?? -1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_alitaErrorInterceptor != null) {
      _alitaErrorInterceptor!(alitaError);
    }
    throw alitaError;
  }

  Future<AlitaNetResponse<T>> send<T>(BaseRequest request) async {
    ///使用Dio发送请求
    AlitaNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(AlitaErrorInterceptor interceptor) {
    _alitaErrorInterceptor = interceptor;
  }

  void printLog(log) {
    log('alita_net:' + log.toString());
  }
}
