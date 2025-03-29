# curl_dio_logger_interceptor

[![Pub](https://img.shields.io/pub/v/dio.svg)](https://pub.dev/packages/dio)
[![Dev](https://img.shields.io/pub/v/dio.svg?label=dev&include_prereleases)](https://pub.dev/packages/dio)

Language: English | [简体中文](README-ZH.md)

Convert dio request into a cURL command.

## Get started

### Install

Add the `dio` package to your
[pubspec dependencies](https://pub.dev/packages/dio/install).

**Before you upgrade: Breaking changes might happen in major and minor versions of packages.<br/>
See the [Migration Guide][] for the complete breaking changes list.**

[Migration Guide]: https://pub.dev/documentation/dio/latest/topics/Migration%20Guide-topic.html

### Super simple to use

```dart
import 'package:dio/dio.dart';

final dio = Dio();

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print(response);
}
```
