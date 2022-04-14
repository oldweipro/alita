import 'package:alita/http/core/alita_error.dart';
import 'package:alita/http/core/alita_net_adapter.dart';
import 'package:alita/http/request/base_request.dart';
import 'package:dio/dio.dart';

///Dio适配器
class DioAdapter extends AlitaNetAdapter {
  @override
  Future<AlitaNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.get) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.post) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.delete) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出HiNetError
      throw AlitaNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<AlitaNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(AlitaNetResponse(
        //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
