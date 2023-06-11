import 'dart:convert';
import 'dart:developer';

import 'package:business/core/network/remote/model/api_response.dart';
import 'package:business/helper/functions.dart';
import 'package:dio/dio.dart';

const baseUrl = 'https://businesskalied.com/api/business/';

class ApiCaller {
  ApiCaller._();

  static final ApiCaller instance = ApiCaller._();

  Dio dio = Dio();

  Future<T?>? requestGet<T>(String url,
          {T Function(dynamic data)? builder,
          Map<String, dynamic>? headers,
          Map<String, dynamic>? queryParameters,
          String? token,
          Function(dynamic data)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(url, headers, dio.get,
            queryParameters: queryParameters, token: token),
        builder,
        onFailure,
      );

  Future<T?>? requestPost<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          Function(dynamic data)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(url, headers, dio.post,
            body: body, token: token),
        builder,
        onFailure,
      );

  Future<T?>? requestPatch<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          Function(dynamic data)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(url, headers, dio.patch,
            body: body!, token: token),
        builder,
        onFailure,
      );

  Future<T?>? requestPut<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int baseUrlFlag = 0,
          Function(dynamic data)? onFailure}) =>
      _handleRequest<T>(
          _adjustRequestParameter(url, headers, dio.put,
              body: body!, token: token),
          builder,
          onFailure);

  Future<T?>? requestDelete<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int baseUrlFlag = 0,
          Function(dynamic data)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(url, headers, dio.delete,
            body: body!, token: token),
        builder,
        onFailure,
      );

  Map<String, dynamic> _getHeader(
      Map<String, dynamic>? headers, bool isMultiPartFile,
      {String? token}) {
    return {
      'Content-Type': isMultiPartFile
          ? 'multipart/form-data'
          : 'application/json-patch+json',
      'accept': 'text/plain',
      'Abp.TenantId': '1',
      'lang': 'ar',
      'Authorization': 'Bearer $token',
    }..addAll(
        headers ?? {},
      );
  }

  Function _adjustRequestParameter(
    String url,
    Map<String, dynamic>? headers,
    Function f, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) {
    String uri = '${baseUrl}api/$url';
    print(uri);
    return () {
      bool isMultiPartFile = body is List
          ? false
          : body?.values.firstWhere(
                (element) {
                  if (element.runtimeType.toString() == 'MultipartFile' ||
                      element.runtimeType.toString() == 'List<MultipartFile>') {
                    return true;
                  } else {
                    return false;
                  }
                },
                orElse: () => null,
              ) !=
              null;
      return (body == null)
          ? f(uri,
              options: Options(
                headers: _getHeader(headers, isMultiPartFile, token: token),
                followRedirects: false,
                validateStatus: (status) {
                  print('$url Response code : ' + status.toString());
                  return true;
                },
              ))
          : f(uri,
              options: Options(
                headers: _getHeader(headers, isMultiPartFile, token: token),
                followRedirects: false,
                validateStatus: (status) {
                  print('$url Response code : ' + status.toString());
                  return true;
                },
              ),
              data:
                  isMultiPartFile ? FormData.fromMap(body) : jsonEncode(body));
    };
  }

  Future<T?>? _handleRequest<T>(
      Function requestMethod, Function? builder, Function? onFailure) async {
    if (builder == null) return Future.value();
    DateTime beforeRequestDate = DateTime.now();
    Response response = await requestMethod();

    log(response.data.toString());

    APIResponse data = APIResponse<T>.fromJson(response.data, builder);
    Duration requestTime = DateTime.now().difference(beforeRequestDate);
    print('Request took ${requestTime.inMilliseconds.toString()} ms');
    if (data.status!)
      return data.data;
    else {
      customSnackBar(message1: data.msg!, message2: '');
      if (onFailure != null) onFailure(data);
    }
    return Future.value();
  }
}
