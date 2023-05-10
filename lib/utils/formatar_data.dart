import 'package:cloud_firestore/cloud_firestore.dart';

formatarData(Timestamp data) {
  return data.toDate();
}

formatarParaTimeStamp(DateTime data) {
  return Timestamp.fromDate(data);
}
