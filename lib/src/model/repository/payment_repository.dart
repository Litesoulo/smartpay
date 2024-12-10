import 'package:pocketbase/pocketbase.dart';
import '../entity/payment_entity.dart';

abstract interface class PaymentRepository {
  Future<List<PaymentEntity>> readMany();
  Future<PaymentEntity> read(String id);
  Future<PaymentEntity> update(PaymentEntity item);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PocketBase _pb;

  PaymentRepositoryImpl({
    required PocketBase pb,
  }) : _pb = pb;

  @override
  Future<PaymentEntity> read(String id) async {
    final result = await _pb.collection(PaymentEntity.className).getOne(id);

    final data = result.data;

    return PaymentEntity.fromJson(data);
  }

  @override
  Future<List<PaymentEntity>> readMany() async {
    final results = await _pb.collection(PaymentEntity.className).getList();

    final data = results.items;

    return data
        .map(
          (e) => PaymentEntity.fromJson(e.data),
        )
        .toList();
  }

  @override
  Future<PaymentEntity> update(PaymentEntity item) async {
    final response = await _pb.collection(PaymentEntity.className).update(
          item.id,
          body: item.toJson(),
        );

    return PaymentEntity.fromJson(response.data);
  }
}
