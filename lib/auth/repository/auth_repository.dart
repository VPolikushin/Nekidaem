import 'package:nekidaem/auth/model/auth_jwt_model.dart';
import 'package:nekidaem/resources/api/api_provider.dart';
import 'package:nekidaem/services/storage_token.dart';

class AuthRepository {
  final api = ApiProvider();

  Future<void> login(String? username, String? password) async {
    final resp = await api.userPost(username, password);

    final UserJwt jwt = UserJwt.fromJson(resp);

    await SecureStorage().writeSecureData('token', jwt.token);
  }

}