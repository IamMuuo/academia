export 'user_service.dart';
export 'rewards_service.dart';

/// The verisafe service provides the base url
/// for user authentication
mixin VerisafeService {
  static const String urlPrefix = "http://192.168.100.2:8000";
  // static const String urlPrefix = "http://34.201.43.66:8000";
}
