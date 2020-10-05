import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  final _auth = FirebaseAuth.instance;

  // ignore: missing_return
  Future<bool> getCurrentUser(context) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {}
    } catch (e) {
      print(e);
    }
  }
}
