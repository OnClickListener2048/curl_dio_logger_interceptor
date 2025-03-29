import 'dart:io';

import 'package:curl_dio_logger_interceptor/curl_dio_logger_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState()  {
    super.initState();
    test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(""),
      ),
    );
  }

  void test() async {
    Dio dio = Dio();
    dio.interceptors.add(CurlDioLoggerInterceptor(
        needResponseHeader: true,
        extraParams: ['--insecure', "-L", "-u 'bob:12345'", "-v"]));

    try {
      // 示例 GET 请求
      Response response = await dio.get('https://httpbin.org/get?name=watson');
    } catch (e) {
      print('fail: $e');
    }

    try {
      // 示例 GET 请求
      Response response =
          await dio.post('https://httpbin.org/post', data: {'name': 'watson'});
    } catch (e) {
      print('fail: $e');
    }

    try {
      // 示例 GET 请求
      Response response = await dio.post('https://httpbin.org/post',
          data: FormData.fromMap({'name': 'watson'}),
          options: Options(headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType
          }));
    } catch (e) {
      print('fail: $e');
    }

    final Directory tempDir = await getTemporaryDirectory();
    var file = File("${tempDir.path}/1.txt");
    file.writeAsBytesSync([1,2,3,4,5,6,7,8,9,10]);

    try {
      // 示例 GET 请求
      Response response = await dio.post('https://httpbin.org/post',
          data: MultipartFile.fromFileSync(file.path,
              filename: "1.txt"),
          options: Options(headers: {
            Headers.contentTypeHeader: Headers.multipartFormDataContentType
          }));
    } catch (e) {
      print('fail: $e');
    }

  }
}
