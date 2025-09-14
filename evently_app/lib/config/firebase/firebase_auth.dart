import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) {
            return UserModel.fromJson(snapshot.data()!);
          },
          toFirestore: (model, _) {
            return model.toJson();
          },
        );
  }

  static Future<bool> signIn({
    required UserModel user,
    required String password,
    required Function onError,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email, password: password);
      user.id = userCredential.user!.uid;

      if (!userCredential.user!.emailVerified) {
        onError('email_not_verified'.tr());
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message ?? 'user_not_found'.tr());
      } else if (e.code == 'wrong-password') {
        onError(e.message ?? 'wrong_password'.tr());
      } else {
        onError(e.message ?? 'sign_in_failed'.tr());
      }
      return false;
    } catch (e) {
      onError(e.toString());
      return false;
    }
  }

  static Future<bool> signUp({
    required UserModel user,
    required String password,
    required void Function(String) onError,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      // تحديث اسم المستخدم في FirebaseAuth
      await userCredential.user!.updateDisplayName(user.name);
      await FirebaseAuth.instance.currentUser?.reload();

      user.id = userCredential.user!.uid;

      await createUserAccount(user);

      // إرسال رسالة تأكيد الإيميل
      await userCredential.user!.sendEmailVerification();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message ?? 'weak_password'.tr());
      } else if (e.code == 'email-already-in-use') {
        onError(e.message ?? 'email_used'.tr());
      } else {
        onError(e.message ?? 'sign_up_failed'.tr());
      }
      return false;
    } catch (e) {
      onError(e.toString());
      return false;
    }
  }

  static Future<void> createUserAccount(UserModel userModel) {
    var docRef = getUsersCollection().doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserModel?> getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    final doc = await getUsersCollection().doc(currentUser.uid).get();
    return doc.data();
  }

  Future<UserModel?> readUser() async {
    try {
      DocumentSnapshot<UserModel> docRef = await getUsersCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return docRef.data();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<void> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn()
          .signIn();

      if (googleSignInAccount == null) return;


      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;


      final credentialUser = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );


      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credentialUser,
      );
      final firebaseUser = userCredential.user;

      final doc = await getUsersCollection().doc(firebaseUser!.uid).get();

      if (!doc.exists) {
        final newUser = UserModel(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          phone: firebaseUser.phoneNumber ?? '',
        );

        await createUserAccount(newUser);
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
