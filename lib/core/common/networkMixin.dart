import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

mixin NetworkMixin {
  late Dio _dio = Dio();

  final String server = FlutterConfig.get('API_URL');

  final String apiKey = FlutterConfig.get('API_KEY');

  Future<Response<Map<String, dynamic>>> get({
    required String endpoint,
    Map<String, dynamic>? query,
    CancelToken? token,
    Options? options,
  }) {
    return _dio.get(
      "$server$endpoint",
      queryParameters: addApiKey(query),
      cancelToken: token,
      options: options,
    );
  }

  Future<Response<Map<String, dynamic>>> post(
    String url,
    Map<String, dynamic> body,
    Map<String, dynamic>? query,
    CancelToken token,
    Options? options,
  ) {
    return _dio.post(
      url,
      data: body,
      queryParameters: addApiKey(query),
      cancelToken: token,
      options: options,
    );
  }

  Map<String, dynamic> addApiKey(Map<String, dynamic>? queryParameter) {
    if (queryParameter == null || !queryParameter.containsKey("apiKey")) {
      if (queryParameter == null) {
        queryParameter = {};
      }
      queryParameter["apiKey"] = apiKey;
    }
    return queryParameter;
  }
}
