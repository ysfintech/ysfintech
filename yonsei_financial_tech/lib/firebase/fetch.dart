import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference papers = FirebaseFirestore.instance.collection('paper');

// // working paper
// Future<DocumentSnapshot> getPaperData() {
//   return papers.get();
// }
