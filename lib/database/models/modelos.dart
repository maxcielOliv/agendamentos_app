import 'package:cloud_firestore/cloud_firestore.dart';

class Modelos {
  static final Modelos _instance = Modelos._();

  Modelos._();

  //factory Modelos().fromFirestore(

    var db = FirebaseFirestore.instance;

// //inserir dados
//   final usuarios = <String, String>{
//   "usuario": "Wanderlan",
//   "senha": "1234"
// };
// //inserir dados
// db.collection("usuarios")
//     .doc("Wanderlan")
//     .set(usuarios)
//     .onError((e, _) => print("Error writing document: $e"));

//
// final docData = {
//   "stringExample": "Hello world!",
//   "booleanExample": true,
//   "numberExample": 3.14159265,
//   "dateExample": Timestamp.now(),
//   "listExample": [1, 2, 3],
//   "nullExample": null
// };

// final nestedData = {
//   "a": 5,
//   "b": true,
// };

// docData["objectExample"] = nestedData;

// db
//     .collection("data")
//     .doc("one")
//     .set(docData)
//     .onError((e, _) => print("Error writing document: $e"));

//deletar documentos
// db.collection("cities").doc("LA").delete().then(
//       (doc) => print("Document deleted"),
//       onError: (e) => print("Error updating document $e"),
//     );

//deleter campos
//final docRef = db.collection("data").doc("one");

// deletar o campo determinado
// final updates = <String, dynamic>{
//   "booleanExample": FieldValue.delete(),
// };

// docRef.update(updates);

}