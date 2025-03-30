import 'package:curl_dio_logger_interceptor/curl_dio_logger_interceptor.dart';
import 'package:dio/dio.dart';

void main() async {
  Dio dio = Dio();
  dio.interceptors.add(CurlDioLoggerInterceptor(
      needResponseHeader: true));

  try {
    // 示例 GET 请求
    Response response = await dio.get('https://httpbin.org/get?name=watson'
        ,options: Options(headers: {
          "key1":"value1",
          "key2":"value2",
          "key3":"value3",
        },
        ),queryParameters: {"foo":"bar"}
    );
    print(response.statusCode);
  } catch (e) {
    print('fail: $e');
  }

  // try {
  //   // 示例 GET 请求
  //   Response response =
  //       await dio.post('https://httpbin.org/post', data: {'name': 'watson'});
  //   print(response.statusCode);
  // } catch (e) {
  //   print('fail: $e');
  // }
  //
  // try {
  //   // 示例 GET 请求
  //   Response response = await dio.post('https://httpbin.org/post',
  //       data: FormData.fromMap({'name': 'watson'}),
  //       options: Options(headers: {
  //         Headers.contentTypeHeader: Headers.formUrlEncodedContentType
  //       }));
  //   print(response.statusCode);
  // } catch (e) {
  //   print('fail: $e');
  // }
  //
  //
  // try {
  //   // 示例 GET 请求
  //   Response response = await dio.post('https://httpbin.org/post',
  //       data: MultipartFile.fromFileSync("/Users/Downloads/1.jpeg",
  //           filename: "1.jpeg"),
  //       options: Options(headers: {
  //         Headers.contentTypeHeader: Headers.multipartFormDataContentType
  //       }));
  //   print(response.data);
  // } catch (e) {
  //   print('fail: $e');
  // }

}
