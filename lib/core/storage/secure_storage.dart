import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limitless_code_template/core/storage/key_value_storage.dart';

/// A [KeyValueStorage] backed by `flutter_secure_storage`
/// (Keychain on iOS/macOS, encrypted storage on Android).
///
/// Secure storage is async-only, so [init] loads all values into an in-memory
/// cache that serves the synchronous getters. Writes go to both the cache and
/// the secure store. [init] must be awaited before any other method is called.
class SecureStorage implements KeyValueStorage {
  SecureStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  final Map<String, String> _cache = {};

  @override
  Future<void> init() async {
    _cache
      ..clear()
      ..addAll(await _storage.readAll());
  }

  @override
  String? getString(String key) => _cache[key];

  @override
  bool? getBool(String key) => switch (_cache[key]) {
    'true' => true,
    'false' => false,
    _ => null,
  };

  @override
  int? getInt(String key) => int.tryParse(_cache[key] ?? '');

  @override
  double? getDouble(String key) => double.tryParse(_cache[key] ?? '');

  @override
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
    _cache[key] = value;
  }

  @override
  Future<void> setBool(String key, bool value) =>
      setString(key, value.toString());

  @override
  Future<void> setInt(String key, int value) =>
      setString(key, value.toString());

  @override
  Future<void> setDouble(String key, double value) =>
      setString(key, value.toString());

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
    _cache.remove(key);
  }
}
