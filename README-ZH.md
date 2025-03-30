# curl_dio_logger_interceptor

[![Pub](https://img.shields.io/badge/pub-v0.0.2-blue)](https://pub.dev/packages/curl_dio_logger_interceptor)

Language: English | [简体中文](README-ZH.md)

将dio请求转换成cURL命令。

## 开始使用

### 安装

添加 `curl_dio_logger_interceptor` 包到你的
[pubspec dependencies](https://pub.dev/packages/curl_dio_logger_interceptor/install).


### 超级简单的使用方式

```dart
    import 'package:curl_dio_logger_interceptor/curl_dio_logger_interceptor.dart';
    Dio dio = Dio();
    dio.interceptors.add(CurlDioLoggerInterceptor(
        needResponseHeader: true));
    ))
```

### 之后你会得到类似这个的输出
    
```dart
curl -X GET "https://httpbin.org/get?name=watson&foo=bar" -i --header "key1: value1" --header "key2: value2" --header "key3: value3"
```

### 完整的使用参数

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
