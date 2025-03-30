# curl_dio_logger_interceptor

[![Pub](https://img.shields.io/badge/pub-v0.0.1-blue)](https://pub.dev/packages/curl_dio_logger_interceptor)

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
