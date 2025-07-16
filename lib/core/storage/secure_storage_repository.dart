import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  final FlutterSecureStorage _storage;

  SecureStorageRepository(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  Future<void> saveDbname(String dbname) async {
    await _storage.write(key: 'dbname', value: dbname);
  }

  Future<String?> getDbname() async {
    return await _storage.read(key: 'dbname');
  }

  Future<void> deleteDbname() async {
    await _storage.delete(key: 'dbname');
  }

  Future<void> savePassword(String dbname) async {
    await _storage.write(key: 'password', value: dbname);
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: 'password');
  }

  Future<void> deletePassword() async {
    await _storage.delete(key: 'password');
  }
}
