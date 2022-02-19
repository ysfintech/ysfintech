// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'dart:html' as html;
// import 'package:ysfintech_admin/model/person.dart';
// import 'package:ysfintech_admin/screens/home/home_screen.dart';
// import 'package:image_whisperer/image_whisperer.dart'; // BlobImage
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:ysfintech_admin/screens/people/add_person.dart';
// import 'package:ysfintech_admin/utils/color.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

// class UpdatePerson {
//   final Map<String, dynamic> person;
//   final String pid;
//   final List<dynamic> initialURL;
//   final String category;
//   // constructor
//   UpdatePerson({this.person, this.pid, this.initialURL, this.category});

//   TextEditingController _nameController = new TextEditingController();
//   TextEditingController _majorController = new TextEditingController();
//   TextEditingController _fieldController = new TextEditingController();

//   var pickImage = null;
//   var blobImage = null;
//   String _imageInfo = '';
//   StateSetter _setState;

//   Future<html.File> _getImgFile() async {
//     html.File pickImage_a =
//         await ImagePickerWeb.getImage(outputType: ImageType.file);
//     _setState(() {
//       pickImage = pickImage_a;
//       blobImage = new BlobImage(pickImage_a, name: pickImage.name);
//       _imageInfo = '${pickImage_a.name}\n';
//     });
//   }

//   void showUpdateDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: new Text("Update Person"),
//               content: new StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//                   _setState = setState;
//                   return SingleChildScrollView(
//                     child: Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           selectImage(_setState),
//                           writeInfo(_setState),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               actions: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     new TextButton(
//                         child: new Text("확인"),
//                         onPressed: () {
//                           _update(_setState);
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

//   //이미지 선택
//   Widget selectImage(StateSetter _setState) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           ElevatedButton.icon(
//             onPressed: _getImgFile,
//             icon: Icon(Icons.check, size: 18),
//             label: Text('Select Image'),
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                 (Set<MaterialState> states) {
//                   if (states.contains(MaterialState.pressed)) return themeBlue;
//                   return themeBlue; // Use the component's default.
//                 },
//               ),
//             ),
//           ),
//           Stack(
//             children: [
//               FutureBuilder(
//                   future: initialURL[0],
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return FutureBuilder(
//                           future: initialURL[1],
//                           builder: (context, snapshot) {
//                             if (snapshot.hasError) {
//                               return Center(child: Text('500 - error'));
//                             } else if (!snapshot.hasData) {
//                               return Center(child: CircularProgressIndicator());
//                             } else {
//                               return Image.network(snapshot.data,
//                                   width: 120, height: 220);
//                             }
//                           });
//                     } else if (!snapshot.hasData) {
//                       return Center(child: CircularProgressIndicator());
//                     } else {
//                       return Image.network(snapshot.data,
//                           width: 120, height: 220);
//                     }
//                   }),
//               Wrap(
//                   direction: Axis.horizontal,
//                   alignment: WrapAlignment.center,
//                   children: <Widget>[
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       switchInCurve: Curves.easeIn,
//                       child: SizedBox(
//                         width: 500,
//                         height: 200,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: 1,
//                             itemBuilder: pickImage != null
//                                 ? (context, index) =>
//                                     Image.network(blobImage.url)
//                                 : (context, index) => Container()),
//                       ),
//                     ),
//                   ]),
//             ],
//           ),
//           Text(_imageInfo, overflow: TextOverflow.ellipsis),
//         ]);
//   }

//   //텍스트 입력 위젯
//   Widget writeInfo(StateSetter _setState) {
//     _nameController.text = person["name"].toString();
//     _majorController.text = person["major"].toString();
//     _fieldController.text = person["field"].toString();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text("이름"),
//         TextFormField(
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             filled: true,
//             fillColor: lightWhite,
//           ),
//           controller: _nameController,
//           enabled: true,
//         ),
//         SizedBox(
//           height: 15.0,
//         ),
//         Text("소속"),
//         TextFormField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               filled: true,
//               fillColor: lightWhite,
//             ),
//             controller: _majorController,
//             enabled: true),
//         SizedBox(
//           height: 15.0,
//         ),
//         Text("전문분야"),
//         TextFormField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               filled: true,
//               fillColor: lightWhite,
//             ),
//             controller: _fieldController,
//             enabled: true),
//       ],
//     );
//   }

//   void _update(StateSetter _setState) async {
//     if (_imageInfo != '') {
//       removeImg(updateImg(_setState));
//     }
//     if (this.category == "yonsei") {
//       await FirebaseFirestore.instance
//           .collection("people_yonsei")
//           .doc(this.pid)
//           .update({
//         "name": _nameController.text,
//         "major": _majorController.text,
//         "field": _fieldController.text
//       });
//     } else if (this.category == "aca") {
//       await FirebaseFirestore.instance
//           .collection("people_aca")
//           .doc(this.pid)
//           .update({
//         "name": _nameController.text,
//         "major": _majorController.text,
//         "field": _fieldController.text
//       });
//     } else if (this.category == "indus") {
//       await FirebaseFirestore.instance
//           .collection("people_indus")
//           .doc(this.pid)
//           .update({
//         "name": _nameController.text,
//         "major": _majorController.text,
//         "field": _fieldController.text
//       });
//     }
//   }

//   String updateImg(StateSetter _setState) {
//     //add img
//     String img_name =
//         this.pid + "." + pickImage.name.split(".")[1].toLowerCase();
//     firebaseStorage.Reference ref = firebaseStorage.FirebaseStorage.instance
//         .ref('gs://ysfintech-homepage.appspot.com/')
//         .child('people/${img_name}');
//     try {
//       ref.putBlob(pickImage);
//     } catch (e) {
//       print(e);
//     }
//     return pickImage.name.split(".")[1].toLowerCase();
//   }

//   void removeImg(String fileForm) {
//     String path;
//     if (fileForm == "jpg") {
//       path = "gs://ysfintech-homepage.appspot.com/people/" + this.pid + ".png";
//     } else {
//       path = "gs://ysfintech-homepage.appspot.com/people/" + this.pid + ".jpg";
//     }
//     firebaseStorage.FirebaseStorage.instance
//         .ref(path)
//         .getDownloadURL()
//         .then((value) {
//       if (value != null) {
//         firebaseStorage.FirebaseStorage.instance.ref(path).delete();
//       }
//     });
//   }
// }
