import 'package:business/helper/constanc.dart';
import 'package:dio/dio.dart';

class ApiRequest {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://businesskalied.com/api/business/api/',
      headers: {
        'Accept': 'application/json',
        'lang': locale.value.languageCode.toString(),
      },
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) => true,
    ));
  }

  // get request
  static getData({
    required String url,
    String? token,
    String? bearerToken,
  }) async {
    if (token != null) {
      dio!.options.headers.addAll({'token': token});
    }
    if (bearerToken != null) {
      dio!.options.headers.addAll({'Authorization': 'Bearer $bearerToken'});
    }
    return await dio!.get(url); // , queryParameters: query
  }

  static Future<Response> postData({
    String? url,
    dynamic body,
    String? token,
    Map<String, String>? header,
  }) async {
    print('Calling uri: ${url}');
    if (token != null) {
      dio!.options.headers.addAll({'token': token});
    }
    if (header != null) {
      dio!.options.headers.addAll(header);
    }
    return await dio!.post(url!, data: body);
  }
  //    await dio.post(url, data: body).then((Response response) {
  //       if (response.statusCode == 200 ||
  //           response.statusCode == 201 ||
  //           response.statusCode == 204) {
  //         print(response.statusCode);
  //         print(response.data);
  //         return response;
  //       } else {
  //
  //       }
  //     });

  Future<Response> putData({
    String? url,
    dynamic body,
    String? token,
    String? bearerToken,
  }) async {
    if (token != null) {
      dio!.options.headers.addAll({'token': token});
    }
    if (bearerToken != null) {
      dio!.options.headers.addAll({'Authorization': 'Bearer $bearerToken'});
    }

    Response response = await dio!.put(url!, data: body);
    // print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // print(response.body + response.statusCode.toString());
    } else if (response.statusCode == 401) {
    } else {
      // print(response.statusCode);
      // errorHandler(response.body, response.statusCode);
    }
    return response;
  }

  /// Delete request
  Future<Response> deleteData({String? url, String? token}) async {
    // print('Calling uri: ${baseUrl + url}');
    if (token != null) {
      dio!.options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    Response response = await dio!.delete(url!);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6
      print(response.data + response.statusCode.toString());
    } else {
      print(response.statusCode);
      print(response.data);
    }
    return response;
  }

// Future<Response> uploadMedia(
//     {String url, File image, String token, String bearerToken}) async {
//   print('Calling uri: ${baseUrl + url}');
//   if (bearerToken != null) {
//     _headers.addAll({'Authorization': 'Bearer $bearerToken'});
//   }
//   Uri apiUrl = Uri.parse(baseUrl + url);
//
//   final mimeTypeData =
//       lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
//   final imageUploadRequest = dio.MultipartRequest('POST', apiUrl);
//   imageUploadRequest.headers.addAll(_headers);
//
//   final file = await http.MultipartFile.fromPath('file', image.path,
//       contentType: MediaType(
//         mimeTypeData[0],
//         mimeTypeData[1],
//       ));
//
//   imageUploadRequest.files.add(file);
//   try {
//     final streamedResponse = await imageUploadRequest.send();
//     final response = await http.Response.fromStream(streamedResponse);
//     return response;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
}
