import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:wigilabs_test/src/core/config/http_client_base.dart';

/// Implementation of generic HTTP Client with caching and error handling
class DioHttpClientImpl implements HttpClient {
  static const String _baseUrl = 'https://restcountries.com/v3.1';
  late final Dio _dio;

  DioHttpClientImpl({required Dio dio}) : _dio = dio {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // Add cache interceptor with 7 days expiration
    _dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.forceCache,
          maxStale: const Duration(days: 7),
        ),
      ),
    );
  }

  @override
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<T> post<T>(
    String endpoint, {
    required dynamic body,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: body,
      );
      return response.data as T;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<T> put<T>(
    String endpoint, {
    required dynamic body,
  }) async {
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: body,
      );
      return response.data as T;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> delete(String endpoint) async {
    try {
      await _dio.delete(endpoint);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Centralized error handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout');
        case DioExceptionType.badResponse:
          return Exception('Bad response: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        case DioExceptionType.unknown:
          return Exception('Unknown error: ${error.message}');
        default:
          return Exception('Error: ${error.message}');
      }
    }
    return Exception(error.toString());
  }
}
