import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ysfintech_admin/model/board.dart';

/// model
import 'package:ysfintech_admin/model/project.dart';

/// models
import '../model/introduction.dart';

/// * REMEMBER *
/// Every data used for update, which includes [Intro], [Project], ...
/// the inner property called `imagePath` is updated via this class (`FireStoreDB`)
/// not from any different class
///
/// [UPDATE] always use `cloneCLASSNAMEWithNewImagePath` function and make shallow copy or deep copy
/// to make update in FireStore
/// or else the image cannot be rendered at the main page, client and admin in both sites
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

  static Future<bool> uploadFile(String filePath, Uint8List bytes) async {
    final storageRef = fireStorageInst.ref(filePath);

    /// upload file
    final uploadResult = await storageRef.putData(
      bytes,
      SettableMetadata(contentType: 'application/pdf'),
    );

    if (uploadResult.state == TaskState.success)
      return true;
    else
      return false;
  }

  static Future<bool> deleteFile(String filePath) async => await fireStorageInst
      .ref(filePath)
      .delete()
      .then((value) => Future.value(true))
      .catchError((err) => Future.value(false));

  /// update document and if the result is fine return `true`
  static Future<bool> updateDocument(
    String collectionName,
    String docID,
    Map<String, dynamic> json,
  ) async =>
      await fireStoreInst
          .collection(collectionName)
          .doc(docID)
          .update(json)
          .then((value) => Future.value(true))
          .onError((error, stackTrace) => Future.value(false));

  /// add document and if the result isfin return `true`
  static Future<bool> addDocument(
    String collectionName,
    Map<String, dynamic> json,
  ) async =>
      await fireStoreInst
          .collection(collectionName)
          .add(json)
          .then((value) => Future.value(true))
          .onError((error, stackTrace) => Future.value(false));

  static Future<bool> deleteDocument(
    String collectionName,
    String docID,
  ) async =>
      await fireStoreInst
          .collection(collectionName)
          .doc(docID)
          .delete()
          .then((value) => Future.value(true))
          .catchError((err) => Future.value(false));

  /// # `Introduction` methods: CRUD =======================================================================

  /// `READ` retrieve all Introduction
  /// returns `List<Intro>` at first index of List
  /// and `Map<int, String>` at the second index, which maps Intro's `id` with FireStore's `document id`
  Stream<List<dynamic>> getIntroStream() {
    Stream<QuerySnapshot> stream =
        fireStoreInst.collection('introduction').snapshots();
    return stream.map((QuerySnapshot snapshot) {
      List<Intro> intros = [];
      Map<int, String> mapper = {};
      for (var doc in snapshot.docs) {
        final parsedIntro = Intro.fromJson(doc.data() as Map<String, dynamic>);
        intros.add(parsedIntro);
        mapper.addAll({parsedIntro.id: doc.id});
      }
      return [intros, mapper];
    }).cast();
  }

  /// `CREATE` add a new Introduction
  addNewIntro(Intro data, Uint8List file) async {
    final imagePath = baseURL + 'introduction' + '/${data.id}.jpg';
    final imageUploadResult = await uploadImage(imagePath, file);
    if (imageUploadResult) {
      Intro updatedData = Intro.clone(data).shallowCopyWithImagePath(imagePath);
      return await addDocument('introduction', updatedData.toJson());
    }
    return Future.value(false);
  }

  /// `UPDATE` update existing Introduction with new Image
  updateIntro(String docID, Intro data, Uint8List file) async {
    final imagePath = baseURL + 'introduction' + '/${data.id}.jpg';

    final imageUploadResult = await uploadImage(imagePath, file);

    if (imageUploadResult) {
      Intro updatedData = Intro.clone(data).shallowCopyWithImagePath(imagePath);

      /// update document's fields
      return await updateDocument('introduction', docID, updatedData.toJson());
    }
    return Future.value(false);
  }

  /// `UPDATE` update existing Introduction without uploading new image
  updateIntroWithoutImage(String docID, Intro data) async =>
      await updateDocument('introduction', docID, data.toJson());

  /// `DELETE` remove existing Introduction
  /// and also stored Image file in the storage
  Future<bool> removeIntro(String docID, int id) async {
    /// remove storage first
    final storageResult =
        await deleteFile(baseURL + 'introduction' + '/$id.jpg');

    if (storageResult) {
      return await deleteDocument('introduction', docID);
    } else {
      return Future.value(false);
    }
  }

  /// # `Project` methods: CRUD =======================================================================

  /// `READ` retrieve all the documents in the Project
  /// returns `documents` and `mapper` to link with
  /// `docID` and `id` field in the document
  Stream<List<dynamic>> getProjectStream() {
    return fireStoreInst
        .collection('project')
        .snapshots()
        .map((QuerySnapshot query) {
      /// create return values
      List<Project> projects = [];
      Map<int, String> mapper = {};
      for (var doc in query.docs) {
        Project parsedDoc =
            Project.fromJson(doc.data() as Map<String, dynamic>);
        projects.add(parsedDoc); // project
        mapper.addAll({parsedDoc.id: doc.id}); // mapper
      }
      return [projects, mapper];
    });
  }

  /// `CREATE` add a new document to the Project
  addNewProject(Project data, Uint8List file) async {
    // store file(image) into storage first
    final imagePath = baseURL + 'project' + '/${data.id}.png';

    final imageUploadResult = await uploadImage(imagePath, file);

    if (imageUploadResult) {
      /// if the file(image) has been uploaded successfully,
      /// then add new document to FireStore
      final Project newProject = Project.cloneWithNewImagePath(data, imagePath);
      return await addDocument('project', newProject.toJson());
    }

    /// else return failure
    return Future.value(false);
  }

  /// `UPDATE` update the specific document in the Project with a new File
  updateProject(String docID, Project data, Uint8List file) async {
    final imagePath = baseURL + 'project' + '/${data.id}.png';

    /// remove previous image in the store first
    final hasRemoved = await deleteFile(imagePath);

    /// then upload image at the same path due to the result
    if (hasRemoved) {
      final isUploaded = await uploadImage(imagePath, file);
      final clonedData = Project.cloneWithNewImagePath(data, imagePath);

      /// check if the image has been uploaded successfully
      if (isUploaded) {
        /// then update new data to FireStore
        return updateDocument('project', docID, clonedData.toJson());
      }
      log('the image has not been uploaded successfully', name: 'PROJECT');
      return Future.value(false);
    }
    log('the image has not been removed successfully', name: 'PROJECT');
    return Future.value(false);
  }

  /// `UPDATE` update the specific document in the Project without a new File
  updateProjectWithoutImage(String docID, Project data) async {
    final imagePath = baseURL + 'project/${data.id}.png';
    final clonedData = Project.cloneWithNewImagePath(data, imagePath);

    /// only update FireStore
    return await updateDocument('project', docID, clonedData.toJson());
  }

  /// `DELETE` remove existing document in the Project
  /// as well as File in the Storage
  removeProject(String hashedID, int docID) async {
    /// remove storage first
    final storageResult = await deleteFile(baseURL + 'project' + '/$docID.png');

    if (storageResult) {
      return await deleteDocument('project', hashedID);
    } else {
      return Future.value(false);
    }
  }

  /// # `Working Papers`, `Collaboration` and `Seminars`
  /// the pages that use `Board` for data-model
  ///
  /// need the colllection names for database management

  /// returns `List<Board>` at the first object of return
  /// and `Map<int, String>` at the last object of the returned object
  /// bind it with your controller's observable data !
  Stream<List<dynamic>> getItemsOfBoard(String collectionName) {
    return fireStoreInst.collection(collectionName).snapshots().map((query) {
      /// parse the items with `Board`
      /// variables to save items and return in `Stream` format
      List<Board> boards = [];
      Map<int, String> mapper = {};

      for (var doc in query.docs) {
        final Board parsedDoc = Board.fromJson(doc);
        boards.add(parsedDoc);
        mapper.addAll({
          parsedDoc.id: doc.id
        }); //  add document ID (hashed ID) and id(key) inside the document
      }

      /// return List<Stream>
      return [boards, mapper];
    });
  }

  /// `html.File` is used for uploading pdf/image both
  Future<bool> addNewBoard({
    required String collectionName,
    required Board newBoard,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    /// used for `Collaboration`
    if (fileBytes == null && newBoard.imagePath == null) {
      return await addDocument(collectionName, newBoard.toJson());
    } else {
      final imagePath = baseURL + collectionName + '/$fileName';
      final uploadResult = await uploadFile(imagePath, fileBytes!);

      if (uploadResult) {
        Board updatedBoard = Board.cloneWith(newBoard, imagePath);
        return await addDocument(collectionName, updatedBoard.toJson());
      }
      return Future.value(false);
    }
  }

  updateBoard({
    required String collectionName,
    required String docId,
    required Board board,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    /// 1. remove existing file from Firebase Storage
    final filePath = board.imagePath;
    if (filePath != null && fileBytes != null && fileName != null) {
      final deleteResult = await deleteFile(filePath);

      /// 2. upload new file to Firebase Storage
      if (deleteResult) {
        final newFilePath = baseURL + collectionName + '/' + fileName;

        final fileUploadResult = await uploadFile(newFilePath, fileBytes);

        /// update document fields
        if (fileUploadResult) {
          final updatedBoard = Board.cloneWith(board, newFilePath);
          return await updateDocument(
              collectionName, docId, updatedBoard.toJson());
        }
      }

      /// upload failure
      else {
        return Future.value(false);
      }
    }

    /// 3. update to `docID` with `board`
    else {
      // no files to be updated
      return await updateDocument(collectionName, docId, board.toJson());
    }
  }

  /// remove file first then remove document
  removeBoard({
    required String collectionName,
    required String docId,
    String? imagePath,
  }) async {
    if (imagePath != null) {
      final deleteResult = await deleteFile(imagePath);
      if (!deleteResult) throw FirebaseException(plugin: 'Delete from Storage');
    }
    return await deleteDocument(collectionName, docId);
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
