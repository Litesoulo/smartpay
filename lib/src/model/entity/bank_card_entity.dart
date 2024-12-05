import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part '../../../generated/src/model/entity/bank_card_entity.g.dart';

@JsonSerializable()
class BankCardEntity extends Equatable {
  final String id;
  final String bankId;
  final String surnameName;
  final String cardNumber;
  final DateTime? expirationDate;

  const BankCardEntity({
    required this.id,
    this.bankId = '',
    this.surnameName = '',
    this.cardNumber = '',
    this.expirationDate,
  });

  factory BankCardEntity.fromJson(Map<String, dynamic> json) => _$BankCardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BankCardEntityToJson(this);

  /// Static method to generate a new UUID
  static String generateId() => const Uuid().v4();

  /// Creates a copy of this BankCardEntity with optional overrides
  BankCardEntity copyWith({
    String? id,
    String? bankId,
    String? surnameName,
    String? cardNumber,
    DateTime? expirationDate,
  }) {
    return BankCardEntity(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      surnameName: surnameName ?? this.surnameName,
      cardNumber: cardNumber ?? this.cardNumber,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        bankId,
        surnameName,
        cardNumber,
        expirationDate,
      ];
}
