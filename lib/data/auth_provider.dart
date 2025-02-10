import 'package:to_do_app/data/auth_repo.dart';
import 'package:to_do_app/model/user_model.dart';

class AuthRepoProvider {
  AuthRepo authRepo;

  AuthRepoProvider({required this.authRepo});

  addUseData({required UserModel userModel, required String password}) {
    authRepo.addDataToSecure(userModel, password);
  }

  Future<UserModel?> fetchUserData() {
    return authRepo.getUserData();
  }

  String hashingPass({required String password}) {
    return authRepo.hashPassword(password);
  }


  fetchRegisteredUserEmailPass(){
    return authRepo.fetchRegisteredEmailPassword();
  }
  bool verifyPass(String password, String hashedPassword) {
    return authRepo.verifyPassword(password, hashedPassword);
  }

  Future<void> clearSecureStorage() async {
    await authRepo.clearSecureStorage();
  }
}
