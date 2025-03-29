# curl_dio_logger_interceptor

[![Pub](https://img.shields.io/pub/v/dio.svg)](https://pub.dev/packages/curl_dio_logger_interceptor)

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
