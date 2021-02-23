import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';

class ShareBookRepositoryImpl {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> isLoggedIn() async {
    try {
      //It was done previous splash screen, it is for single user
      User response = _auth.currentUser;
      if (response.uid == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<Status> addShareBook({UserModel userModel}) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(
          email: userModel.fullName, password: userModel.password);

      if (response.user.uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(response.user.uid)
            .set(
          {
            'fullName': userModel.fullName,
            'contact': userModel.contact,
            'email': userModel.email,
          },
        );
        //after register it will directly login so we haveto signout
        await _auth.signOut();
        return Status(
            message: "Register Success !", isSuccess: true, data: response);
      } else {
        return Status(
            message: "Could not register !", isSuccess: false, data: null);
      }
    } catch (e) {
      return Status(message: e.toString(), isSuccess: false, data: null);
    }
  }

  Future<Status> loginUser({UserModel userModel}) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      ))
          .user;
      if (user.uid != null) {
        return Status(message: 'Success', isSuccess: true, data: user);
      } else {
        return Status(message: 'Could not Login', isSuccess: false, data: null);
      }
    } catch (e) {
      return Status(message: e.toString(), isSuccess: false, data: null);
    }
  }
}
