import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserProfPic({
    required File file,
    required String uid,
  }) async {
    Reference fileRef = _firebaseStorage
        .ref('users/prof_pics')
        .child('$uid${path.extension(file.path)}');
    UploadTask task = fileRef.putFile(file);
    return task.then((path) {
      if (path.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
  }
}
