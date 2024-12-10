import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  static const className = 'payment';

  static const keyAmount = 'amount';
  static const keyReceiver = 'receiver';
  static const keySender = 'sender';
  static const keyBank = 'bank';
  static const keyBankIdentifier = 'bank_identifier';

  const PaymentEntity({
    required this.id,
    this.amount = 0,
    this.receiverId = '',
    this.senderId = '',
    this.bankIdentifier = '',
  });

  final String id;
  final double amount;
  final String receiverId;
  final String senderId;
  final String bankIdentifier;

  static PaymentEntity fromJson(Map<String, dynamic> json) {
    return PaymentEntity(
      id: json['id'],
      amount: double.tryParse(json[PaymentEntity.keyAmount].toString()) ?? 0,
      bankIdentifier: json[PaymentEntity.keyBank],
      receiverId: json[PaymentEntity.keyReceiver],
      senderId: json[PaymentEntity.keySender],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PaymentEntity.keyAmount: amount,
      PaymentEntity.keyBank: bankIdentifier,
      PaymentEntity.keyReceiver: receiverId,
      PaymentEntity.keySender: senderId,
    };
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        receiverId,
        senderId,
        bankIdentifier,
      ];
}
