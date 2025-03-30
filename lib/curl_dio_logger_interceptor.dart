import 'dart:convert';

import 'package:dio/dio.dart';

/// A [Dio] interceptor that prints the curl command.
class CurlDioLoggerInterceptor extends Interceptor {
  CurlDioLoggerInterceptor({
    this.needResponseHeader = false,
    this.printOnRequest = false,
    this.extraParams,
    this.ignoreLongParam = true,
    this.ignoreLongParamLength = 1024,
    this.logPrint = _debugPrint,
  });

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
        'curl -X ${options.method} "${options.uri.toString()}"';

    if (needResponseHeader) {
      curlCommand += " -i";
    }

    options.headers.forEach((key, value) {
      if (ignoreLongParam) {
        if (key.length > ignoreLongParamLength ||
            value.toString().length > ignoreLongParamLength) {
          return;
        }
      }
      curlCommand += ' --header "$key: $value"';
    });

    if (options.data != null) {
      if (options.data is FormData) {
        FormData formData = options.data;
        formData.fields.forEach((entry) {
          if (ignoreLongParam) {
            if (entry.key.length > ignoreLongParamLength ||
                entry.value.toString().length > ignoreLongParamLength) {
              return;
            }
          }
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

    extraParams?.forEach((command) {
      curlCommand += " $command";
    });

    logPrint(curlCommand);
  }
}

void _debugPrint(Object? object) {
  assert(() {
    printWrapped(object.toString());
    return true;
  }());
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,1000}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
