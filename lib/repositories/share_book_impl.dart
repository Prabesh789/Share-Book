import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';

class ShareBookRepositoryImpl {
  Future<Status> addShareBook({UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance.collection('share_book_user').doc().set(
        {
          'fullName': userModel.fullName,
          'contact': userModel.contact,
          'email': userModel.email,
          'status': false,
        },
      );
      return Status(message: "Register Success !", isSuccess: true, data: null);
    } catch (e) {
      return Status(message: e.toString(), isSuccess: false, data: null);
    }
  }

  Future<Status> loginUser({UserModel userModel}) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: null, password: null))
          .user;
    } catch (e) {}
  }
}
