import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_alchemy_app/View/Registered_Content.dart';

import 'package:flutter/material.dart';

Future<List<String>> getHobbyIds() async {
  // コレクションhobbyを参照する
  final hobbyCollection = FirebaseFirestore.instance.collection('hobby');

  // コレクション内のすべてのドキュメントを取得する
  final querySnapshot = await hobbyCollection.get();

  // ドキュメントidを配列に格納する
  final hobbyIds = querySnapshot.docs.map((doc) => doc.id).toList();

  return hobbyIds;
}

class HobbyRegistrationB {
  // コレクションhobbyを参照する
  final hobbyCollection = FirebaseFirestore.instance.collection('hobby');
  // FirestoreからドキュメントIDを取得する
  Future<List<String>> getHobbyIds() async {
    final querySnapshot = await hobbyCollection.get();

    // ドキュメントidを配列に格納する
    final hobbyIds = querySnapshot.docs.map((doc) => doc.id).toList();

    return hobbyIds;
  }
}

void searchNavigate({
  required String username,
  required String emailOrPhoneNumber,
  required String password,
  required List<String> selectedTags,
  required BuildContext context, // 修正
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Registered_Content_Page(
        username: username,
        emailOrPhoneNumber: emailOrPhoneNumber,
        password: password,
        selectedTags: selectedTags,
      ),
    ),
  );
}
