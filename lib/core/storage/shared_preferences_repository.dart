import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesRepository {
  Future<void> init();

  Future<bool> setInt(String key, int value);
  int getInt(String key, {int defaultValue = 0});

  Future<bool> setString(String key, String value);
  String getString(String key, {String defaultValue = ''});

  Future<bool> setBool(String key, bool value);
  bool getBool(String key, {bool defaultValue = false});

  Future<bool> remove(String key);
  Future<bool> clear();
}

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  void _checkInitialization() {
    if (!_isInitialized || _prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _checkInitialization();
    return await _prefs!.setInt(key, value);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    _checkInitialization();
    return _prefs!.getInt(key) ?? defaultValue;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _checkInitialization();
    return await _prefs!.setString(key, value);
  }

  @override
  String getString(String key, {String defaultValue = ''}) {
    _checkInitialization();
    return _prefs!.getString(key) ?? defaultValue;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _checkInitialization();
    return await _prefs!.setBool(key, value);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    _checkInitialization();
    return _prefs!.getBool(key) ?? defaultValue;
  }

  @override
  Future<bool> remove(String key) async {
    _checkInitialization();
    return await _prefs!.remove(key);
  }

  @override
  Future<bool> clear() async {
    _checkInitialization();
    return await _prefs!.clear();
  }
}
