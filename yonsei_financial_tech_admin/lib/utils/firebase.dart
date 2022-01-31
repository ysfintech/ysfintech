import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// model
import 'package:ysfintech_admin/model/project.dart';

/// models
import '../model/introduction.dart';

class FireStoreDB {
  static String baseURL = 'gs://ysfintech-homepage.appspot.com/';

  static FirebaseFirestore fireStoreInst = FirebaseFirestore.instance;
  static FirebaseStorage fireStorageInst = FirebaseStorage.instance;

  /// retrieve download URL for Image Widget
  static Future<String> getDownloadURL(String path) async =>
      await fireStorageInst
          .ref(path)
          .getDownloadURL()
          .then((result) => result, onError: (err) => '');

  /// Upload Image to the specific reference
  /// which will be different by collections
  /// this methods handles data in the Cloud Storage
  static Future<bool> uploadImage(String filePath, Uint8List file) async {
    final storageRef = fireStorageInst.ref(filePath);

    /// upload image
    final uploadResult = await storageRef.putData(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    if (uploadResult.state == TaskState.success)
      return true;
    else
      return false;
  }

  static Future<bool> deleteImage(String filePath) async =>
      await fireStorageInst
          .ref(filePath)
          .delete()
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));

  /// # `Introduction` methods: CRUD =======================================================================

  /// `READ` retrieve all Introduction
  /// returns `List<Intro>` at first index of List
  /// and `Map<int, String>` at the second index, which maps Intro's `id` with FireStore's `document id`
  static Stream<List<dynamic>> getIntroStream() {
    return fireStoreInst
        .collection('introduction')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Intro> intros = [];
      Map<int, String> mapper = {};
      for (var doc in query.docs) {
        final parsedIntro = Intro.fromJson(doc.data());
        intros.add(parsedIntro);
        mapper.addAll({parsedIntro.id: doc.id});
      }
      return [intros, mapper];
    });
  }

  /// `CREATE` add a new Introduction
  static addNewIntro(Intro data, Uint8List file) async {
    final imagePath = baseURL + 'introduction' + '/${data.id}.jpg';
    final imageUploadResult = await uploadImage(imagePath, file);
    if (imageUploadResult) {
      Intro updatedData = Intro.clone(data).shallowCopyWithImagePath(imagePath);
      return await fireStoreInst
          .collection('introduction')
          .add(updatedData.toJson())
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));
    }
    return Future.value(false);
  }

  /// `UPDATE` update existing Introduction with new Image
  static updateIntro(String docID, Intro data, Uint8List file) async {
    final imagePath = baseURL + 'introduction' + '/${data.id}.jpg';

    final imageUploadResult = await uploadImage(imagePath, file);

    if (imageUploadResult) {
      Intro updatedData = Intro.clone(data).shallowCopyWithImagePath(imagePath);

      /// update document's fields
      return await fireStoreInst
          .collection('introduction')
          .doc(docID)
          .update(updatedData.toJson())
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));
    }
    return Future.value(false);
  }

  /// `UPDATE` update existing Introduction without uploading new image
  static updateIntroWithoutImage(String docID, Intro data) async {
    return await fireStoreInst
        .collection('introduction')
        .doc(docID)
        .update(data.toJson())
        // return bool for the result
        .then((value) => Future.value(true))
        .catchError((err) => Future.value(false));
  }

  /// `DELETE` remove existing Introduction
  /// and also stored Image file in the storage
  static Future<bool> removeIntro(String docID, int id) async {
    /// remove storage first
    final storageResult =
        await deleteImage(baseURL + 'introduction' + '/$id.jpg');

    if (storageResult) {
      return await fireStoreInst
          .collection('introduction')
          .doc(docID)
          .delete()
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));
    } else {
      return Future.value(false);
    }
  }

  /// # `Project` methods: CRUD =======================================================================

  /// `READ` retrieve all the documents in the Project
  /// returns `documents` and `mapper` to link with
  /// `docID` and `id` field in the document
  static Stream<List<dynamic>> getProjectStream() {
    return fireStoreInst
        .collection('project')
        .snapshots()
        .map((QuerySnapshot query) {
      /// create return values
      List<Project> projects = [];
      Map<int, String> mapper = {};
      for (var doc in query.docs) {
        Project parsedDoc = Project.fromJson(doc.data());
        projects.add(parsedDoc); // project
        mapper.addAll({parsedDoc.id: doc.id}); // mapper
      }
      return [projects, mapper];
    });
  }

  /// `CREATE` add a new document to the Project
  static addNewProject(Project data, Uint8List file) async {
    // store file(image) into storage first
    final imagePath = baseURL + 'project' + '/${data.id}.png';

    final imageUploadResult = await uploadImage(imagePath, file);

    if (imageUploadResult) {
      /// if the file(image) has been uploaded successfully,
      /// then add new document to FireStore
      final Project newProject = Project.cloneWithNewImagePath(data, imagePath);
      return await fireStoreInst
          .collection('project')
          .add(newProject.toJson())
          .then((value) => Future.value(true))
          .catchError((err) {
        print(err);
        Future.value(false);
      });
    }

    /// else return failure
    return Future.value(false);
  }

  /// `UPDATE` update the specific document in the Project with a new File
  // static
  /// `UPDATE` update the specific document in the Project without a new File

  /// `DELETE` remove existing document in the Project
  /// as well as File in the Storage
  static removeProject(String hashedID, int docID) async {
     /// remove storage first
    final storageResult =
        await deleteImage(baseURL + 'project' + '/$docID.png');

    if (storageResult) {
      return await fireStoreInst
          .collection('project')
          .doc(hashedID)
          .delete()
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));
    } else {
      return Future.value(false);
    }
  }
}

// class Field {
//   final String collection;
//   // constructor
//   Field({this.collection});

//   String getImageName(String imagePath) => imagePath.substring(
//       ('gs://ysfintech-homepage.appspot.com/' + this.collection + '/').length);
//   // upload
//   String getImagePath(html.File file) =>
//       'gs://ysfintech-homepage.appspot.com/' +
//       this.collection +
//       '/' +
//       file.name;
//   // to firebase storage
//   Future<void> uploadImage(html.File data) async {
//     firebaseStorage.Reference ref = firebaseStorage.FirebaseStorage.instance
//         .ref('gs://ysfintech-homepage.appspot.com/')
//         .child('${this.collection}/${data.name}');
//     try {
//       await ref.putBlob(data);
//     } catch (e) {
//       print(e);
//     }
//   }

//   // download - redirect
//   Future<void> downloadFile(String imagePath) async {
//     // 1) set url
//     String downloadURL = await firebaseStorage.FirebaseStorage.instance
//         .ref(imagePath)
//         .getDownloadURL();
//     // 2) request
//     html.AnchorElement anchorElement =
//         new html.AnchorElement(href: downloadURL);
//     anchorElement.download = downloadURL;
//     anchorElement.click();
//   }

//   // upload Document
//   Future<void> uploadDocument(
//       html.File uploadFile, Board data, BuildContext context) {
//     if (this.collection == 'paper') {
//       return uploadImage(uploadFile).then((value) => FirebaseFirestore.instance
//           .collection('paper')
//           .add({
//             'id': data.id,
//             'content': data.content,
//             'date': Timestamp.fromDate(data.date),
//             'title': data.title,
//             'view': data.view,
//             'writer': data.writer,
//             'imagePath': data.imagePath
//           })
//           .then((value) => print("project updated"))
//           .then((value) => Navigator.pop(context, true)));
//     } else {
//       return FirebaseFirestore.instance
//           .collection('work')
//           .add({
//             'id': data.id,
//             'content': data.content,
//             'date': Timestamp.fromDate(data.date),
//             'title': data.title,
//             'view': data.view,
//             'writer': data.writer,
//           })
//           .then((value) => print("project updated"))
//           .then((value) => Navigator.pop(context, true));
//     }
//   }

//   // update field
//   Future<void> updateDocument(BuildContext context,
//       {html.File file,
//       String pathID,
//       String content,
//       String title,
//       String imagePath}) {
//     if (file != null) {
//       return uploadImage(file).then((value) => print('image uploaded')).then(
//           (value) => FirebaseFirestore.instance
//               .collection(this.collection)
//               .doc(pathID)
//               .update(
//                   {'content': content, 'title': title, 'imagePath': imagePath})
//               .then((value) => print("project updated"))
//               .then((value) => Navigator.pop(context, true)));
//     } else {
//       return FirebaseFirestore.instance
//           .collection(this.collection)
//           .doc(pathID)
//           .update({'content': content, 'title': title, 'imagePath': imagePath})
//           .then((value) => print("project updated"))
//           .then((value) => Navigator.pop(context, true));
//     }
//   }

//   //remove field
//   Future<void> removeField(String pathID, {BuildContext context}) {
//     return FirebaseFirestore.instance
//         .collection(this.collection)
//         .doc(pathID)
//         .delete()
//         .then((value) {
//           if (context != null) {
//             return Navigator.pop(context);
//           }
//         })
//         .then((value) => print("field deleted"))
//         .catchError((err) => print(err));
//   }

//   // remove storage
//   Future<void> removeStorage(String imagePath) =>
//       firebaseStorage.FirebaseStorage.instance
//           .ref(imagePath)
//           .getDownloadURL()
//           .then((value) =>
//               firebaseStorage.FirebaseStorage.instance.ref(imagePath).delete())
//           .catchError((err) => print('file does not exist!'));
// }
