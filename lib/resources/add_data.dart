import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/utils.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    SettableMetadata metadata;

    if (fileName!.toLowerCase().endsWith('.png')) {
      metadata = SettableMetadata(contentType: 'image/png');
    } else if (fileName!.toLowerCase().endsWith('.jpg') ||
        fileName!.toLowerCase().endsWith('.jpeg')) {
      metadata = SettableMetadata(contentType: 'image/jpeg');
    } else {
      throw Exception('Invalid file format');
    }

    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String?> saveData(
      {required Uint8List file,
      required String username,
      required String? email,
      required String? fileName}) async {
    String response = 'Some error occurred';

    try {
      String imageUrl = await uploadImageToStorage(
          'images/profile_pictures/$email/$fileName', file);

      await _firestore.collection('Usernames').doc(currentUser!.email).set({
        'Username': username,
        'UserEmail': email,
        'ProfilePicture': imageUrl,
      });

      response = 'Success!';

      return response;
    } catch (e) {
      response = e.toString();

      return response;
    }
  }

  Future<String?> saveDataPost({
    required Uint8List file,
    required String? email,
    required String? title,
    required String? fileName,
  }) async {
    String _URLValue = '';
    String response = 'Some error occurred';

    try {
      String imageUrl = await uploadImageToStorage(
          'images/posts/$email/$title/$fileName', file);

      // await _firestore.collection('Usernames').doc(currentUser!.email).set({
      //   'UserEmail': email,
      //   'Title': title,
      //   'ImageUrl': imageUrl,
      // });

      _URLValue = imageUrl;

      print(_URLValue);
      return _URLValue;
    } catch (e) {
      response = e.toString();

      return response;
    }
  }
}
