import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  final storage = const FlutterSecureStorage();

  Future<String?> getUserToken() async {
    String? token = await storage.read(key: 'jwt_token');
    return token;
  }

  Future<void> setUserToken({required String userToken}) async {
    await storage.write(key: 'jwt_token', value: userToken);
  }
}
