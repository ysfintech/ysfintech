import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/material.dart';

class Field {
  final String collection;
  // constructor
  Field({this.collection});

  String getImageName(String imagePath) => imagePath.substring(
      ('gs://ysfintech-homepage.appspot.com/' + this.collection + '/').length);
  // upload
  String getImagePath(html.File file) =>
      'gs://ysfintech-homepage.appspot.com/' +
      this.collection +
      '/' +
      file.name;
  // to firebase storage
  Future<void> uploadImage(html.File data) async {
    firebaseStorage.Reference ref = firebaseStorage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/')
        .child('${this.collection}/${data.name}');
    try {
      await ref.putBlob(data);
    } catch (e) {
      print(e);
    }
  }

  // download - redirect
  Future<void> downloadFile(String imagePath) async {
    // 1) set url
    String downloadURL = await firebaseStorage.FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();
    // 2) request
    html.AnchorElement anchorElement =
        new html.AnchorElement(href: downloadURL);
    anchorElement.download = downloadURL;
    anchorElement.click();
  }

  // update field
  Future<void> updateDocument(BuildContext context,
      {html.File file,
      String pathID,
      String content,
      String title,
      String imagePath}) {
    if (file != null) {
      return uploadImage(file).then((value) => FirebaseFirestore.instance
          .collection(this.collection)
          .doc(pathID)
          .update({'content': content, 'title': title, 'imagePath': imagePath})
          .then((value) => print("project updated"))
          .then((value) => Navigator.pop(context, true)));
    } else {
      return FirebaseFirestore.instance
          .collection(this.collection)
          .doc(pathID)
          .update({'content': content, 'title': title, 'imagePath': imagePath})
          .then((value) => print("project updated"))
          .then((value) => Navigator.pop(context, true));
    }
  }

  //remove field
  Future<void> removeField(String pathID, {BuildContext context}) {
    return FirebaseFirestore.instance
        .collection(this.collection)
        .doc(pathID)
        .delete()
        .then((value) {
          if (context != null) {
            return Navigator.pop(context);
          }
        })
        .then((value) => print("field deleted"))
        .catchError((err) => print(err));
  }
}
