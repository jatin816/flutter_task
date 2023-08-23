import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageServiceConstants {
  static var kUserPrefix = 'UserData';
  static var kAuthToken = 'TokenValue';
}

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService();

  static Future<SecureStorageService> getInstance() async {
    return _instance;
  }

  // Create storage
  final _storage = const FlutterSecureStorage();

  Future initialise() async {
    // Add the following line
  }

  Future<void> _save(String value, String key) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> _getValueFor(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> _delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteUserData() async {
    await _delete(SecureStorageServiceConstants.kUserPrefix);
  }

  Future<void> deleteAuthToken() async {
    await _delete(SecureStorageServiceConstants.kAuthToken);
  }

  Future<void> saveAuthTokenData(String token) async {
    await _save(token, SecureStorageServiceConstants.kAuthToken);
  }

  Future<String?> getAuthToken() async {
    var jsonString =
        await _getValueFor(SecureStorageServiceConstants.kAuthToken);
    if (jsonString != null) {
      return jsonString;
    } else {
      return null;
    }
  }
}
