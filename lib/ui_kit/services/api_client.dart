part of '../local_pub.dart';

class ApiClient {
  String? _authToken;
  late String _baseUrl;
  String get baseUrl => _baseUrl;
  String userAgent = 'Dart/2.16 (dart:io)';
  late Dio dio;
  CancelToken cancelToken = CancelToken();

  ApiClient(
      [String baseUrl =
          'https://usman-stable.cognitivehealthintl.com/rms/v1']) {
    _baseUrl = baseUrl;
    dio = initializeDio();
    // if (kIsWeb) dio.httpClientAdapter = BrowserHttpClientAdapter();
  }

  void setAuthToken() {
    // _authToken = Preferences.instance.getAuthToken();
  }

  void clearAuthToken() {
    _authToken = '';
  }

  Map<String, dynamic> get _headers {
    _authToken = window.localStorage['auth_token'];
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': _authToken,
      'User-Agent': userAgent.toLowerCase(),
    };
  }

  Dio initializeDio() {
    final BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  }

  Future<ApiResponse<T>> login<T>({
    ApiObject? request,
    required String endpoint,
    ModelCallback? fromJson,
  }) async {
    return _exceptionWrapper(() async {
      final resp = await dio.post(
        endpoint,
        options: Options(headers: _headers),
        data: request,
        cancelToken: cancelToken,
      );
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var data = resp.data;

        _authToken = data['auth_token'] ?? '';
        window.localStorage['auth_token'] = _authToken!;

        data = data is Map ? data : {"data": data};

        return compute(_isolatedParser, {
          'data': data,
          'code': resp.statusCode,
          'fromJson': fromJson,
        });
      }
      return ApiResponse(
        status: 'Error',
        code: resp.statusCode,
        message: resp.statusMessage,
      );
    });
  }

  Future<ApiResponse<T>> post<T>({
    ApiObject? request,
    required String endpoint,
    ModelCallback? fromJson,
  }) async {
    return _exceptionWrapper(() async {
      final resp = await dio.post(
        endpoint,
        options: Options(headers: _headers),
        data: request,
        cancelToken: cancelToken,
      );
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var data = resp.data;

        data = data is Map ? data : {"data": data};

        return compute(_isolatedParser, {
          'data': data,
          'code': resp.statusCode,
          'fromJson': fromJson,
        });
      }
      return ApiResponse(
        status: 'Error',
        code: resp.statusCode,
        message: resp.statusMessage,
      );
    });
  }

  Future<ApiResponse<T>> get<T>({
    ApiObject? request,
    required String endpoint,
    ModelCallback? fromJson,
  }) async {
    return _exceptionWrapper(() async {
      final resp = await dio.get(
        endpoint,
        options: Options(headers: _headers),
        queryParameters: request,
        cancelToken: cancelToken,
      );
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var data = resp.data;

        data = data is Map ? data : {"data": data};

        return compute(_isolatedParser, {
          'data': data,
          'code': resp.statusCode,
          'fromJson': fromJson,
        });
      }
      return ApiResponse(
        status: 'Error',
        code: resp.statusCode,
        message: resp.statusMessage,
      );
    });
  }

  Future<ApiResponse<T>> patch<T>({
    ApiObject? request,
    required String endpoint,
    ModelCallback? fromJson,
  }) async {
    return _exceptionWrapper(() async {
      final resp = await dio.patch(
        endpoint,
        options: Options(headers: _headers),
        data: request,
        cancelToken: cancelToken,
      );
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var data = resp.data;

        data = data is Map ? data : {"data": data};

        return compute(_isolatedParser, {
          'data': data,
          'code': resp.statusCode,
          'fromJson': fromJson,
        });
      }
      return ApiResponse(
        status: 'Error',
        code: resp.statusCode,
        message: resp.statusMessage,
      );
    });
  }

  Future<ApiResponse<T>> uploadMedia<T>({
    required dynamic file,
    required String endpoint,
    String folderName = '',
    ModelCallback? fromJson,
  }) async {
    return _exceptionWrapper(() async {
      String fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
        "folderName": folderName,
      });
      final resp = await dio.post(
        endpoint,
        options: Options(headers: _headers),
        data: formData,
        cancelToken: cancelToken,
      );
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var data = resp.data;

        data = data is Map ? data : {"data": data};

        return compute(_isolatedParser, {
          'data': data,
          'code': resp.statusCode,
          'fromJson': fromJson,
        });
      }
      return ApiResponse(
        status: 'Error',
        code: resp.statusCode,
        message: resp.statusMessage,
      );
    });
  }

  Future<ApiResponse<T>> _exceptionWrapper<T>(
      Future<ApiResponse<T>> Function() apiCaller) async {
    try {
      return await apiCaller();
    } on DioException catch (error) {
      if (error.type == DioExceptionType.unknown) {
        if (error.error is SocketException) {
          final eError = error.error as SocketException;
          return _throwException(
            eError.message,
            error.response?.statusCode,
          );
        }
        return _throwException(
          error.response?.data['message'] ??
              error.response?.statusMessage ??
              error.message,
          error.response?.statusCode,
        );
      }
      if (error.type == DioExceptionType.sendTimeout) {
        return _throwException('Request Time Out', error.response?.statusCode);
      }
      if (error.type == DioExceptionType.receiveTimeout) {
        return _throwException('Response Time Out', error.response?.statusCode);
      }
      if (error.type == DioExceptionType.badResponse) {
        if (error.message?.contains(
                'The request returned an invalid status code of 502.') ??
            false) {
          return _throwException(
            error.message,
            error.response?.statusCode,
          );
        }
        return _throwException(
          error.response?.data['message'] ??
              error.response?.statusMessage ??
              error.message,
          error.response?.statusCode,
        );
      }
      if (error.type == DioExceptionType.connectionError) {
        return _throwException(
          error.response?.data['message'] ??
              error.response?.statusMessage ??
              error.message,
          error.response?.statusCode,
        );
      }
      return ApiResponse<T>(
        status: 'Error',
        message: error.response?.data['message'] ??
            error.response?.statusMessage ??
            error.message,
        code: error.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse<T>(
        status: 'Error',
        message: 'Something went wrong',
        code: -1,
      );
    }
  }
}

ApiResponse<T> _isolatedParser<T>(Map<String, dynamic> params) {
  final data = params['data'];
  final code = params['code'];
  final fromJson = params['fromJson'];
  T? parsedData;
  if (fromJson != null) {
    parsedData = fromJson(data);
    return ApiResponse<T>(status: 'Ok', code: code, data: parsedData);
  }
  return ApiResponse<T>(status: 'Ok', code: code, data: data);
}

ApiResponse<T> _throwException<T>(dynamic message, [int? code]) {
  return ApiResponse<T>(
    status: 'Error',
    message: message is List ? message.first : message,
    code: code ?? -1,
  );
}

typedef ApiObject = Map<String, dynamic>;
typedef ModelCallback = Function(ApiObject);

enum ApiType { login, post, get, patch }
