import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/Hobby_Registration.dart'; // SelectedHobby.dartのパスに合わせて修正

void validateAndNavigate(BuildContext context, String username,
    String emailOrPhoneNumber, String password) {
  String errorText = '';

  if (username.isEmpty) {
    errorText = 'ユーザー名が入力されていません';
  } else if (emailOrPhoneNumber.isEmpty) {
    errorText = 'メールアドレスまたは電話番号が入力されていません';
    // } else if (!_isValidEmailOrPhoneNumber(emailOrPhoneNumber)) {
    //   errorText = 'メールアドレスまたは電話番号が正しく入力されていません';
  } else if (password.isEmpty ||
      password.length < 8 ||
      !_isValidPassword(password)) {
    errorText = 'パスワードが正しく入力されていません';
  }
  if (errorText.isEmpty) {
    // 条件を満たしている場合、次の画面に遷移
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedHobby(
          username: username,
          emailOrPhoneNumber: emailOrPhoneNumber,
          password: password,
        ),
      ),
    );
  } else {
    // 条件を満たしていない場合はエラーメッセージを表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorText),
      ),
    );
  }
}

//bool _isValidEmailOrPhoneNumber(String input) {
//   // 正規表現パターン（例: メールアドレス）
//   // String emailPattern =
//   //     r"/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)";

//   // // 正規表現パターン（例: 電話番号）
//   // String phonePattern = r'^[0-9]{10,}$'; // 電話番号は10桁以上の数字としています

//   // RegExp emailRegExp = RegExp(emailPattern);
//   // RegExp phoneRegExp = RegExp(phonePattern);

//   // メールアドレスまたは電話番号のいずれかに一致するか確認
//   if (RegExp(r"/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)")
//           .hasMatch(input) ||
//       RegExp(r'^[0-9]{10,}$').hasMatch(input)) {
//     return true;
//   } else {
//     return false;
//   }
// }

bool _isValidPassword(String input) {
  // パスワードのバリデーションロジックを実装
  // 例: 8文字以上の半角英数字チェックなど
  return true;
}
