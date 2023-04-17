import '../veiculo.dart';
import 'dao.dart';

class VeiculoDao extends Dao<Veiculo> {
  @override
  Future<Veiculo?> get(String id) async {
    final res = await db.collection('veiculo').doc(id).get();
    return res.exists ? Veiculo.fromFirestore(res) : null;
  }

  // Future<List<Veiculo?>> getModelo(String nome) async {
  //   final res = await db
  //       .collection('veiculo')
  //       .where(nome, isEqualTo: true)
  //       .get()
  //       .then((value) {
  //     for (var docSnapshot in value.docs);
  //   });
  //   return res.docs.map((e) => Veiculo.fromFirestore(e)).toList();
  // }

  @override
  Future<List<Veiculo>> getAll() async {
    final res = await db.collection('veiculo').get();
    return res.docs.map((e) => Veiculo.fromFirestore(e)).toList();
  }
}
