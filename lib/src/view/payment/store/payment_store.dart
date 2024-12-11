import 'package:mobx/mobx.dart';

import '../../../model/entity/payment_entity.dart';
import '../../../model/repository/payment_repository.dart';

part '../../../../generated/src/view/payment/store/payment_store.g.dart';

class PaymentStore = _PaymentStore with _$PaymentStore;

abstract class _PaymentStore with Store {
  final PaymentRepository _paymentRepository;

  _PaymentStore({required PaymentRepository paymentRepository}) : _paymentRepository = paymentRepository;

  @observable
  @readonly
  ObservableFuture<List<PaymentEntity>> paymentsFuture = ObservableFuture.value([]);

  @action
  Future<void> getPayments() async {
    paymentsFuture = ObservableFuture(_paymentRepository.readMany());
    await paymentsFuture;
  }

  @observable
  @readonly
  ObservableFuture<PaymentEntity?> newPaymentFuture = ObservableFuture.value(null);

  @action
  Future<void> makePayment(PaymentEntity payment) async {
    newPaymentFuture = ObservableFuture(_paymentRepository.create(payment));
    await newPaymentFuture;
  }
}
