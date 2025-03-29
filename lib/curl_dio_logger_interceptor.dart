import 'dart:convert';

import 'package:dio/dio.dart';

/**
 * @author watson
 */


class CurlDioLoggerInterceptor extends Interceptor {
  CurlDioLoggerInterceptor({
    this.needResponseHeader = false,
    this.printOnRequest = false,
    this.extraParams,
    this.logPrint = _debugPrint,
  });

  bool needResponseHeader;
  bool printOnRequest = false;
  List<String>? extraParams = [];
  void Function(Object object) logPrint;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (printOnRequest) {
      printCurlCommand(options);
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!printOnRequest) {
      printCurlCommand(response.requestOptions);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printCurlCommand(err.requestOptions);

    handler.next(err);
  }

  printCurlCommand(RequestOptions options) {
    String curlCommand =
        'curl -X ${options.method} "${options.baseUrl}${options.path}"';

    if (needResponseHeader) {
      curlCommand += " -i";
    }


    options.headers.forEach((key, value) {
      curlCommand += ' --header "$key: $value"';
    });

    if (options.data != null) {

      if (options.data is FormData) {
        FormData formData = options.data;
        formData.fields.forEach((entry) {
          curlCommand += ' --form "${entry.key}=${entry.value}"';
        });
      } else if (options.data is MultipartFile) {
        MultipartFile multipartFile = options.data;

        curlCommand +=
            ' --form ${multipartFile.filename}=@"<replace this to your file path!!!>"';
      } else if (options.data is Map) {
        curlCommand += ' --data \'${jsonEncode(options.data)}\'';
      }
    }


    extraParams?.forEach((command){
      curlCommand += " $command";
    });

    logPrint(curlCommand);

  }


}
void _debugPrint(Object? object) {
  assert(() {
    print(object);
    return true;
  }());
}