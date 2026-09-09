/// A singleton that holds the current auth token in memory.
/// Updated immediately after login/logout so the DioConsumer
/// can always read the latest token synchronously.
class TokenManager {
  TokenManager._();
  static final TokenManager _instance = TokenManager._();
  static TokenManager get instance => _instance;

  String? _token;

  /// Returns the current access token.
  String? get token => _token;

  /// Call this right after a successful login / token refresh.
  void setToken(String? token) => _token = token;

  /// Call this on logout.
  void clearToken() => _token = null;
}
