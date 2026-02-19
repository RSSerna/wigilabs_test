/// Generic HTTP Client interface following RESTful principles
abstract interface class HttpClient {
  /// Generic GET request
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  /// Generic POST request
  Future<T> post<T>(
    String endpoint, {
    required dynamic body,
  });

  /// Generic PUT request
  Future<T> put<T>(
    String endpoint, {
    required dynamic body,
  });

  /// Generic DELETE request
  Future<void> delete(String endpoint);
}
