# curl_dio_logger_interceptor

[![Pub](https://img.shields.io/badge/pub-v0.0.2-blue)](https://pub.dev/packages/curl_dio_logger_interceptor)

Language: English | [简体中文](README-ZH.md)

Convert dio request into a cURL command.

## Get started

### Install

Add the `curl_dio_logger_interceptor` package to your
[pubspec dependencies](https://pub.dev/packages/curl_dio_logger_interceptor/install).

### Super simple to use

```dart
import 'package:curl_dio_logger_interceptor/curl_dio_logger_interceptor.dart';
  Dio dio = Dio();
  dio.interceptors.add(CurlDioLoggerInterceptor(
    needResponseHeader: true));
```

### then you will get something like this

```dart
curl -X GET "https://httpbin.org/get?name=watson&foo=bar" -i --header "key1: value1" --header "key2: value2" --header "key3: value3"
```

### full use parameter

```dart
  /**
   * 是否打印出服务器回应的 HTTP 标头。
   * English: Print the server response HTTP headers.
   */
  bool needResponseHeader;
  /**
   * 是否在请求开始前打印出 curl 命令。
   * English: Print the curl command before the request starts.
   */
  bool printOnRequest = false;
  /**
   * 是否忽略长参数。
   * English: Whether to ignore long parameters.
   */
  bool ignoreLongParam = true;
  /**
   * 忽略长参数的长度。
   * English: The length of the long parameter to be ignored.
   */
  int ignoreLongParamLength = 1024;
  /**
   * 额外的参数。
   * English: Additional parameters.
   */
  List<String>? extraParams = [];
  /**
   * 打印日志的方法。
   * English: The method to print logs.
   */
  void Function(Object object) logPrint;
```