import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Get_User_Hobby {

  List<String> _hobbyList = [];  // ユーザーの趣味を格納するリスト
  String userId = '';  // ユーザーIDを格納する変数
  
  // ユーザーデータを取得する関数
  Future<List<String>> getUserHobbyData() async {
    // SharedPreferences インスタンスを作成
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ユーザーIDを取得
    userId = prefs.getString('userID') ?? '';

    print('UserID: $userId');

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // ユーザーデータを取得
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      // ユーザーの趣味を取得
      _hobbyList = List<String>.from(userData['hobby_user']['hobby_List']);

      print(_hobbyList);
    } catch (e) {
      print('Error: $e');
      // エラーが発生した場合の適切な処理をここに追加する
    }
    return _hobbyList;
  }
}

