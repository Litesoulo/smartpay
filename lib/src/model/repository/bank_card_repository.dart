import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entity/bank_card_entity.dart';

abstract interface class BankCardRepository {
  Future<List<BankCardEntity>> getBankCards();
  Future<void> saveBankCard(BankCardEntity bankCard);
  Future<void> removeBankCard(String id);
}

class BankCardRepositoryImpl implements BankCardRepository {
  final SharedPreferences _prefs;

  static const String _bankCardsKey = 'bank_cards';

  BankCardRepositoryImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  Future<List<BankCardEntity>> getBankCards() async {
    final jsonString = _prefs.getString(_bankCardsKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => BankCardEntity.fromJson(json)).toList();
  }

  @override
  Future<void> saveBankCard(BankCardEntity bankCard) async {
    final existingCards = await getBankCards();
    final updatedCards = [...existingCards, bankCard];
    final jsonList = updatedCards.map((card) => card.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _prefs.setString(_bankCardsKey, jsonString);
  }

  @override
  Future<void> removeBankCard(String id) async {
    final existingCards = await getBankCards();
    final updatedCards = existingCards.where((card) => card.id != id).toList();
    final jsonList = updatedCards.map((card) => card.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _prefs.setString(_bankCardsKey, jsonString);
  }
}
