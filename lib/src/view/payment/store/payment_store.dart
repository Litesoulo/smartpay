import 'package:mobx/mobx.dart';

import '../../../../main.dart';
import '../../../model/entity/payment_entity.dart';
import '../../../model/repository/payment_repository.dart';
import '../../transaction_history/transaction_history_screen.dart';

part '../../../../generated/src/view/payment/store/payment_store.g.dart';

class PaymentStore = _PaymentStore with _$PaymentStore;

abstract class _PaymentStore with Store {
  final PaymentRepository _paymentRepository;

  _PaymentStore({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository {
    _initReactions();
  }

  _initReactions() {
    reaction(
      (_) => type,
      (_) => getPayments,
    );
  }

  @observable
  @readonly
  ObservableFuture<List<PaymentEntity>> paymentsFuture = ObservableFuture.value([]);

  @action
  Future<void> getPayments() async {
    paymentsFuture = ObservableFuture(_paymentRepository.readMany());
    await paymentsFuture;
  }

  @computed
  List<PaymentEntity> get paymentsList => type == TransactionTypeEnum.income ? incomePayments : outcomePayments;

  @computed
  List<PaymentEntity> get incomePayments =>
      paymentsFuture.value
          ?.where(
            (e) => e.type == TransactionTypeEnum.income,
          )
          .toList() ??
      [];

  @computed
  List<PaymentEntity> get outcomePayments =>
      paymentsFuture.value
          ?.where(
            (e) => e.type == TransactionTypeEnum.outcome,
          )
          .toList() ??
      [];

  @observable
  @readonly
  TransactionTypeEnum type = kIsBusiness ? TransactionTypeEnum.income : TransactionTypeEnum.outcome;

  @action
  setTransactionType(TransactionTypeEnum value) => type = value;

  @observable
  @readonly
  ObservableFuture<PaymentEntity?> newPaymentFuture = ObservableFuture.value(null);

  @action
  Future<void> makePayment(PaymentEntity payment) async {
    newPaymentFuture = ObservableFuture(_paymentRepository.create(payment));
    await newPaymentFuture;
  }

  dispose() async {
    newPaymentFuture = ObservableFuture.value(null);
  }
}
