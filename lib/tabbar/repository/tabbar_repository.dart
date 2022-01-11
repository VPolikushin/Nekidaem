import 'dart:convert';

import 'package:nekidaem/resources/api/api_provider.dart';
import 'package:nekidaem/services/storage_token.dart';
import 'package:nekidaem/tabbar/model/card_model.dart';

class TabBarRepository {
  final api = ApiProvider();

  Future<List<MyCard>> fetchCards(int row) async {
    final token = await SecureStorage().readSecureData('token');
    final response = await api.getCards(token, row);
    List<MyCard> cards = (response as List).map<MyCard>((_card) => MyCard.fromJson(_card as Map<String, dynamic>)).toList();
    return cards;
  }
}