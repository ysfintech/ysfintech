// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ysfintech_admin/screens/home/home_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

// class DelPerson {
//   final String pid;
//   final int pnum;
//   final String category;
//   // constructor
//   DelPerson({this.pid, this.pnum, this.category});
//   void showDelDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: new Text("Delete Person"),
//               content: new Text("선택한 Person을 삭제합니다."),
//               actions: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     new TextButton(
//                         child: new Text("확인"),
//                         onPressed: () {
//                           _delete();
//                           Navigator.pop(context);
//                           Navigator.of(context).pushReplacement(
//                               new MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return new HomeScreen(tap_index: 1);
//                           }));
//                         }),
//                     new TextButton(
//                         child: new Text("취소"),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         }),
//                   ],
//                 ),
//               ]);
//         });
//   }

//   void _delete() async {
//     if (this.category == "yonsei") {
//       await FirebaseFirestore.instance
//           .collection("people_yonsei")
//           .doc(this.pid)
//           .delete();
//     } else if (this.category == "aca") {
//       await FirebaseFirestore.instance
//           .collection("people_aca")
//           .doc(this.pid)
//           .delete();
//     } else if (this.category == "indus") {
//       await FirebaseFirestore.instance
//           .collection("people_indus")
//           .doc(this.pid)
//           .delete();
//     }
//     _settingNum();
//     _removeImage();
//   }

//   void _settingNum() async {
//     if (this.category == "yonsei") {
//       await FirebaseFirestore.instance
//           .collection("people_yonsei")
//           .get()
//           .then((QuerySnapshot qs) {
//         qs.docs.forEach((doc) {
//           if (doc.data()["number"] > this.pnum) {
//             FirebaseFirestore.instance
//                 .collection("people_yonsei")
//                 .doc(doc.id)
//                 .update({"number": doc.data()["number"] - 1});
//           }
//         });
//       });
//     } else if (this.category == "aca") {
//       await FirebaseFirestore.instance
//           .collection("people_aca")
//           .get()
//           .then((QuerySnapshot qs) {
//         qs.docs.forEach((doc) {
//           if (doc.data()["number"] > this.pnum) {
//             FirebaseFirestore.instance
//                 .collection("people_aca")
//                 .doc(doc.id)
//                 .update({"number": doc.data()["number"] - 1});
//           }
//         });
//       });
//     } else if (this.category == "indus") {
//       await FirebaseFirestore.instance
//           .collection("people_indus")
//           .get()
//           .then((QuerySnapshot qs) {
//         qs.docs.forEach((doc) {
//           if (doc.data()["number"] > this.pnum) {
//             FirebaseFirestore.instance
//                 .collection("people_indus")
//                 .doc(doc.id)
//                 .update({"number": doc.data()["number"] - 1});
//           }
//         });
//       });
//     }
//   }

//   void _removeImage() async {
//     String jpgPath =
//         "gs://ysfintech-homepage.appspot.com/people/" + this.pid + ".jpg";
//     String pngPath =
//         "gs://ysfintech-homepage.appspot.com/people/" + this.pid + ".png";
//     bool del_success = false;
//     await firebaseStorage.FirebaseStorage.instance
//         .ref(jpgPath)
//         .getDownloadURL()
//         .then((value) {
//       if (value != null) {
//         firebaseStorage.FirebaseStorage.instance.ref(jpgPath).delete();
//         del_success = true;
//       }
//     });
//     if (del_success == false) {
//       await firebaseStorage.FirebaseStorage.instance
//           .ref(pngPath)
//           .getDownloadURL()
//           .then((value) {
//         if (value != null) {
//           firebaseStorage.FirebaseStorage.instance.ref(pngPath).delete();
//           del_success = true;
//         }
//       }).catchError((err) => print('file does not exist!'));
//     }
//   }
// }
