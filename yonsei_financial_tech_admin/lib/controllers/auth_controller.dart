
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class AuthController extends GetxController {
  /// to use in single-ton
  static AuthController instance = Get.find();

  late FirebaseAuth _firebaseAuth;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    _firebaseAuth = FirebaseAuth.instance;

    /// check user and init
    firebaseUser = Rx<User?>(_firebaseAuth.currentUser);

    /// bind the user
    firebaseUser.bindStream(_firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    super.onReady();
  }

  /// if the user is none, bring the screen to initial screen
  _setInitialScreen(User? user) {
    if (user == null)
      Get.offAllNamed('/');
    else
      Get.offAllNamed('/home');
  }

  /// sign-in with firebase on email
  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final signInResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (signInResult.credential != null) {
        // session
        _firebaseAuth.setPersistence(Persistence.LOCAL);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        bottomSnackBar(
          'Not Registered User',
          e.toString(),
        );
      } else if (e.code == 'wrong-password') {
        bottomSnackBar(
          'Wrong Password!',
          e.toString(),
        );
      } else {
        bottomSnackBar(
          'Unknown',
          e.toString(),
        );
      }
    }
  }

  /// sign-out
  void signOut() async => await _firebaseAuth.signOut();
}
