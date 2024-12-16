import 'package:equatable/equatable.dart';

import '../../view/transaction_history/transaction_history_screen.dart';

class PaymentEntity extends Equatable {
  static const className = 'payment';

  static const keyAmount = 'amount';
  static const keyReceiver = 'receiver';
  static const keySender = 'sender';
  static const keyBank = 'bank';
  static const keyBankIdentifier = 'bank_identifier';
  static const keyDate = 'date';
  static const keyIsSuccess = 'isSuccess';

  const PaymentEntity({
    required this.id,
    this.amount = 0,
    this.receiverId = '',
    this.senderId = '',
    this.bankIdentifier = '',
    this.type = TransactionTypeEnum.income,
    this.date,
    this.isSuccess = false,
  });

  final String id;
  final double amount;
  final String receiverId;
  final String senderId;
  final String bankIdentifier;
  final TransactionTypeEnum type;
  final DateTime? date;
  final bool isSuccess;

  static PaymentEntity fromJson(Map<String, dynamic> json) {
    return PaymentEntity(
      id: json['id'],
      amount: double.tryParse(json[keyAmount].toString()) ?? 0,
      bankIdentifier: json[keyBank],
      receiverId: json[keyReceiver],
      senderId: json[keySender],
      date: DateTime.tryParse(json[keyDate]),
      isSuccess: json[keyIsSuccess],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyAmount: amount,
      keyBank: bankIdentifier,
      keyReceiver: receiverId,
      keySender: senderId,
      keyDate: date?.toIso8601String(),
      keyIsSuccess: isSuccess,
    };
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        receiverId,
        senderId,
        bankIdentifier,
        type,
        date,
        isSuccess,
      ];
}
