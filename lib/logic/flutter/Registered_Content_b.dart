import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/search.dart';

void newregistration({
  required String username,
  required String emailOrPhoneNumber,
  required String password,
  required List<String> selectedTags,
  required BuildContext context,
}) async {
  if (isValidEmail(emailOrPhoneNumber)) {
    // emailの場合の処理
    await registerWithEmail(
        username, emailOrPhoneNumber, password, selectedTags, context);
    // Firestoreにユーザー情報を保存
  } else {
    // 電話番号の場合の処理
    // ここに電話番号での登録処理を追加
  }
}

Future<void> registerWithEmail(String username, String email, String password,
    List<String> selectedTags, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // 登録成功時の処理
    // 登録成功したユーザーのUID
    String userId = userCredential.user!.uid;
    // Firestoreにユーザー情報を保存
    await saveUserInfoToFirestore(
        userId, username, email, password, selectedTags);

    // 登録成功後に画面遷移
    navigateToNextScreen(context);
  } catch (e) {
    // 登録失敗時のエラー処理
    print("Error: $e");
  }
}

bool isValidEmail(String input) {
  // ここに簡単なメールアドレスのバリデーションを実装
  // 正確なバリデーションはプロジェクトの要件により異なります
  return RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
}

Future<void> saveUserInfoToFirestore(
  String userId,
  String username,
  String emailOrPhoneNumber,
  String password,
  List<String> selectedTags,
) async {
  try {
    // Firestoreのusersコレクションにユーザー情報を保存
    List<String> hobbyIds = await getHobbyIds(selectedTags);
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'user': {
        'user_id': userId,
        'user_name': username,
        'e-mail': emailOrPhoneNumber,
        'phone_number': '',

        //'password': password, // パスワードの保存はセキュリティ上の理由から非推奨です。通常は保存しないか、安全な方法で保存します。
      },
      'hobby_user': {'user_id': hobbyIds}
    });

    // 保存成功時の処理
  } catch (e) {
    if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
      // メールアドレスが既に使用されている場合の処理
      print('エラー: メールアドレスは既に使用されています。');
    } else {
      // その他のエラーの処理
      print('エラー: $e');
    }
  }
}

Future<List<String>> getHobbyIds(List<String> selectedTags) async {
  // hobbyコレクションからselectedTagsと一致するhobby_idを取得する処理
  List<String> hobbyIds = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hobby')
        .where('selectedTags', arrayContains: selectedTags)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      hobbyIds.add(doc.id);
    }
  } catch (e) {
    print("Error getting hobby ids: $e");
  }

  return hobbyIds;
}

// 画面遷移する関数
void navigateToNextScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchPage()), // 遷移先のウィジェットを指定
  );
}
