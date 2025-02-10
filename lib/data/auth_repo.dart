import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthRepo {
  AuthRepo();

  final secureStorage = const FlutterSecureStorage();

  addDataToSecure(UserModel userModel, String password) async {

    // if(await secureStorage.)

    await secureStorage.write(key: 'userFullName', value: userModel.fullName);
    await secureStorage.write(key: 'userEmail', value: userModel.email);
    await secureStorage.write(key: 'id', value: userModel.id);

    debugPrint("hashed pass ${hashPassword(password)}");
    await secureStorage.write(
        key: 'userPassword', value: hashPassword(password));
  }

  Future<UserModel?> getUserData() async {
    String? fullName = await secureStorage.read(key: 'userFullName');
    String? email = await secureStorage.read(key: 'userEmail');
    String? id = await secureStorage.read(key: 'id');

    if (fullName != null && email != null) {
      debugPrint("full name storedddd ${fullName}");
      return UserModel(fullName: fullName, email: email, id: id!);
    }
    return null;
  }

  String hashPassword(String password) {
    final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    return hashedPassword;
  }



  fetchRegisteredEmailPassword() async {
    String? fetchedEmail = await secureStorage.read(key: 'userEmail');
    String? fetchedHashPassword = await secureStorage.read(key: 'userPassword');
return {
  "email":fetchedEmail,
  'password':fetchedHashPassword
};
    // if(email==fetchedEmail && verifyPassword(password, fetchedHashPassword??'')){
    //
    // };
  }

  bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  Future<void> clearSecureStorage() async {
    await secureStorage.deleteAll();
    print("Secure storage cleared.");
  }
}
