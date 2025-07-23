import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reservas_app/core/constants/app_constants.dart';

class SecureStorageRepository {
  final FlutterSecureStorage _secureStorage;

  const SecureStorageRepository(this._secureStorage);

  // Token management
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: AppConstants.authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: AppConstants.authTokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: AppConstants.authTokenKey);
  }

  // Database name management
  Future<void> saveDbname(String dbname) async {
    await _secureStorage.write(key: AppConstants.dbnameKey, value: dbname);
  }

  Future<String?> getDbname() async {
    return await _secureStorage.read(key: AppConstants.dbnameKey);
  }

  Future<void> deleteDbname() async {
    await _secureStorage.delete(key: AppConstants.dbnameKey);
  }

  // Password management
  Future<void> savePassword(String password) async {
    await _secureStorage.write(key: AppConstants.passwordKey, value: password);
  }

  Future<String?> getPassword() async {
    return await _secureStorage.read(key: AppConstants.passwordKey);
  }

  Future<void> deletePassword() async {
    await _secureStorage.delete(key: AppConstants.passwordKey);
  }

  // Username management
  Future<void> saveUsername(String username) async {
    await _secureStorage.write(key: AppConstants.usernameKey, value: username);
  }

  Future<String?> getUsername() async {
    return await _secureStorage.read(key: AppConstants.usernameKey);
  }

  Future<void> deleteUsername() async {
    await _secureStorage.delete(key: AppConstants.usernameKey);
  }

  // Clear all secure data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
