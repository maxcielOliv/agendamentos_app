class Env {
  static const Map<String, String> _keys = {
    'apiKeyWeb': String.fromEnvironment('apiKeyWeb'),
    'appIdWeb': String.fromEnvironment('appIdWeb'),
    'apiKeyAndroid': String.fromEnvironment('apiKeyAndroid'),
    'appIdAndroid': String.fromEnvironment('appIdAndroid'),
    'apiKeyIos': String.fromEnvironment('apiKeyIos'),
    'appIdIos': String.fromEnvironment('appIdIos'),
    'apiKeyMac': String.fromEnvironment('apiKeyMac'),
    'appIdMac': String.fromEnvironment('appIdMac')
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

  static String get getApiKeyWeb => _getKey('apiKeyWeb');
  static String get getAppIdWeb => _getKey('appIdWeb');
  static String get getAppIdAndroid => _getKey('apiKeyAndroid');
  static String get getAppIdIos => _getKey('apiKeyIos');
  static String get getAppIdMac => _getKey('apiKeyMac');
}
