import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/upload_book_model.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // Future<bool> isLoggedIn() async {
  //   try {
  //     //It was done previous splash screen, it is for single user
  //     User response = _auth.currentUser;
  //     if (response.uid == null) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } catch (e) {}
  //   return false;
  // }

  Future<String> isLoggedIn() async {
    try {
      //It was done previous splash screen, it is for single user
      User response = _auth.currentUser;
      if (response.uid != null) {
        return response.uid;
      } else {
        return null;
      }
    } catch (e) {}
    return null;
  }

  Future<Status> addShareBook({UserModel userModel}) async {
    try {
      User response = (await _auth.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password))
          .user;

      if (response.uid != null) {
        String fileName = path.basename(userModel.image.path);
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('user_profile')
            .child(fileName);
        firebase_storage.UploadTask uploadTask =
            reference.putFile(userModel.image);
        firebase_storage.TaskSnapshot storageTaskSnapshot;
        uploadTask.then((value) {
          if (value != null) {
            storageTaskSnapshot = value;
            storageTaskSnapshot.ref.getDownloadURL().then(
              (downloadUrl) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(response.uid)
                    .set(
                  {
                    'image': downloadUrl,
                    'fullName': userModel.fullName,
                    'contact': userModel.contact,
                    'email': userModel.email,
                    'password': userModel.password,
                  },
                );
                //after register it will directly login so we haveto signout
                await _auth.signOut();
              },
            );
          }
        });
        return Status(
            message: "Register Success !", isSuccess: true, data: response);
      } else {
        return Status(
            message: "Could not register !", isSuccess: false, data: null);
      }
    } catch (e) {
      return Status(message: e.message, isSuccess: false, data: null);
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
      return Status(message: e.message, isSuccess: false, data: null);
    }
  }

  Future<Status> uploadBook({UploadBookModel uploadBookModel}) async {
    try {
      final response = await _firebaseFirestore.collection('books').doc().set(
        {
          'bookImage': uploadBookModel.bookImage,
          'bookTitle': uploadBookModel.bookTitle,
          'publishedDate': uploadBookModel.publishedDate,
          'selectedBookType': uploadBookModel.selectedBookType,
          'shareType': uploadBookModel.shareType,
          'bookDescription': uploadBookModel.bookDescription,
          'amount': uploadBookModel.amount,
          'uploadedBy': uploadBookModel.uploadedBy,
        },
      );
      return Status(message: 'Success', isSuccess: true, data: null);
    } catch (e) {
      return Status(message: e.toString(), isSuccess: false, data: null);
    }

    // try {
    //   return Status(message: 'Success', isSuccess: true, data: null);
    // } catch (e) {
    //   return Status(message: e.toString(), isSuccess: false, data: null);
    // }
  }
}
