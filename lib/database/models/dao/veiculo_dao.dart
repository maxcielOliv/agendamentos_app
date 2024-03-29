import '../veiculo.dart';
import 'dao.dart';

class VeiculoDao extends Dao<Veiculo> {
  @override
  Future<Veiculo?> get(String id) async {
    final res = await db.collection('veiculo').doc(id).get();
    return res.exists ? Veiculo.fromFirestore(res) : null;
  }

  @override
  Future<List<Veiculo>> getAll() async {
    final res = await db.collection('veiculo').get();
    return res.docs.map((e) => Veiculo.fromFirestore(e)).toList();
  }

  @override
  // ignore: override_on_non_overriding_member
  Stream<List<Veiculo>> getAllStream() async* {
    yield* db
        .collection('veiculo')
        .snapshots()
        .map((e) => e.docs.map((e) => Veiculo.fromFirestore(e)).toList());
  }
}
