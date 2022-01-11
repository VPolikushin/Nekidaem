import 'package:dio/dio.dart';

class ApiProvider {
  final _baseUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1/';
  final _loginUrl = 'users/login/';
  final _cardsUrl = 'cards/';

  Dio dio = Dio();

  Future<dynamic> userPost(String? username, String? password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    try {
      final response = await dio.post(_baseUrl + _loginUrl, data: formData);
      return response.data;
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> getCards(String token, int queryParam) async {
    final Map<String, dynamic> header = {'Authorization': 'JWT $token'};
    final Map<String, dynamic> queryParametrs = {'row': '$queryParam'};
    try {
      final response = await dio.get(
        _baseUrl + _cardsUrl,
        queryParameters: queryParametrs,
        options: Options(headers: header),
      );
      return response.data;
    } catch(e) {
      print(e);
    }
  }

}