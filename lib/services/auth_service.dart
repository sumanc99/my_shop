// lib/services/auth_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcrypt/bcrypt.dart'; // Corrected import

class AuthService {
  static const String _authBoxName = 'authBox';
  static const String _shopNameKey = 'shopName';
  static const String _hashedPasswordKey = 'hashedPassword';

 // lib/services/auth_service.dart
static Future<void> init() async {
  try {
    if (!Hive.isBoxOpen(_authBoxName)) {
      await Hive.openBox<String>(_authBoxName);
    }
  } catch (e) {
    // Handle the error gracefully, maybe log it or show a user-friendly message
    print('Error opening auth box: $e');
    // Depending on your app's needs, you might want to re-throw,
    // or show an error screen and prevent app usage until resolved.
  }
}

  static Future<void> register({
    required String shopName,
    required String password,
  }) async {
    final box = Hive.box<String>(_authBoxName);
    // Use BCrypt.hashpw for hashing
    final String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt()); // gensalt() generates a new salt each time

    await box.put(_shopNameKey, shopName);
    await box.put(_hashedPasswordKey, hashedPassword);
  }

  static Future<String?> getShopName() async {
    final box = Hive.box<String>(_authBoxName);
    return box.get(_shopNameKey);
  }

  static Future<bool> verifyPassword(String password) async {
    final box = Hive.box<String>(_authBoxName);
    final String? storedHashedPassword = box.get(_hashedPasswordKey);

    if (storedHashedPassword == null) {
      return false; // No password registered
    }

    // Use BCrypt.checkpw for verification
    return BCrypt.checkpw(password, storedHashedPassword);
  }

  static Future<bool> isAuthenticated() async {
    final box = Hive.box<String>(_authBoxName);
    return box.containsKey(_shopNameKey) && box.containsKey(_hashedPasswordKey);
  }

  static Future<void> logout() async {
    final box = Hive.box<String>(_authBoxName);
    await box.clear(); // Clears all authentication data
  }
}