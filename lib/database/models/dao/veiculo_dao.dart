import '../veiculo.dart';
import 'dao.dart';

class VeiculosDao extends Dao<Veiculo> {
  @override
  Future<Veiculo?> get(String id) async {
    final res = await db.collection('veiculo').doc(id).get();
    return res.exists ? Veiculo.fromFirestore(res) : null;
  }

  Future<Veiculo?> getModelo(String nome) async {
      final res = await db.collection('veiculo').where('modelo').get();
        if (res.size > 0) {
          return Veiculo.fromFirestore(res.docs.first);
        }
  }

  @override
  Future<List<Veiculo>> getAll() async {
    final res = await db.collection('veiculo').get();
    return res.docs.map((e) => Veiculo.fromFirestore(e)).toList();
  }
}
