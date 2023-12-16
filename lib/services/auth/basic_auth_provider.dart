import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone_app/services/auth/auth_exceptions.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/cache_manager.dart';

class BasicAuthProvider {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static String? verifyId;
  static User currentCustome() {
    return firebaseAuth.currentUser!;
  }

  static Future<bool> login(String email, String password) async {
    try {
      final signInResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (signInResult.user != null) {
        //log(' this is ${signInResult.user!.photoURL.toString()}');
        // CacheManager.setValue(userIsLoggedInCacheKey, true);
        // CacheManager.setValue(userNameCacheKey, signInResult.user!.displayName);
        // CacheManager.setValue(userIdCacheKey, signInResult.user!.uid);
        // CacheManager.setValue(userEmailCacheKey, signInResult.user!.email);
        // CacheManager.setValue(
        //     userProfileImgUrlCacheKey, signInResult.user!.photoURL);
        // CacheManager.setValue(userPasswordCacheKey, password);
        // AppConstants.userIsLoggedIn = true;
        // AppConstants.userName = signInResult.user!.displayName!;
        // AppConstants.userId = signInResult.user!.uid;
        // AppConstants.userEmail = signInResult.user!.email!;
        // AppConstants.userPassword = password;
        // AppConstants.userProfileImgUrl = signInResult.user!.photoURL;
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return false;
          throw InvalidEmailAuthException();
        case 'user-disabled':
          return false;

          throw UserDisabledAuthException();
        case 'user-not-found':
          return false;

          throw UserNotFoundAuthException();
        case 'wrong-password':
          return false;

          throw WrongPasswordAuthException();
        default:
          return false;

          throw OperationErrorAuthException();
      }
    } catch (e) {
      return false;

      throw OperationErrorAuthException();
    }
  }

  static Future<bool> updateUserDisplayName(String name) async {
    try {
      await firebaseAuth.currentUser!.updateDisplayName(name);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      // throw OperationErrorAuthException();
      log('error updating display name');
      return false;
    }
  }

  static Future<bool> updateUserEmail(String email) async {
    try {
      await firebaseAuth.currentUser!.updateEmail(email);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      // throw OperationErrorAuthException();
      log('error updating email');
      return false;
    }
  }

  static Future<bool> updateUserPassword(String password) async {
    try {
      await firebaseAuth.currentUser!.updatePassword(password);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      // throw OperationErrorAuthException();
      log('error updating display name');
      return false;
    }
  }

  static Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // await firebaseAuth.currentUser!.updatePhoneNumber(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          verifyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      log('2 ${verifyId.toString()}');
    } catch (e) {
      //TODO add auth exeptions
      // throw OperationErrorAuthException();
      log('error updating display name');
    }
  }

  static Future<bool> confirmOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId!, smsCode: smsCode);

      await firebaseAuth.currentUser!.updatePhoneNumber(credential);
      await firestore
          .collection('customers')
          .where('email', isEqualTo: firebaseAuth.currentUser!.email)
          .get()
          .then((value) async {
        await firestore
            .collection('customers')
            .doc(value.docs.first.id)
            .update({'phone_number': firebaseAuth.currentUser!.phoneNumber});
      });
      return true;
    } catch (ex) {
      log(ex.toString());
      log('aywa henaaaaaaa');
      return false;
    }

    // Create a PhoneAuthCredential with the code
  }
  // static Future<void> updateUserPhoneNumber(String phoneNumber) async {
  //   try {
  //     await firebaseAuth.currentUser!.updatePhoneNumber(phoneNumber);
  //   } catch (e) {
  //     //TODO add auth exeptions
  //     // throw OperationErrorAuthException();
  //     log('error updating display name');
  //   }
  // }

  // static Future<void> updateUserEmail(String email) async {
  //   try {
  //     await firebaseAuth.currentUser!.updateEmail(email);
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case 'invalid-email':
  //         throw InvalidEmailAuthException();
  //       case 'email-already-in-use':
  //         throw EmailAlreadyInUseAuthException();
  //       case 'requires-recent-login':
  //         throw RequiresRecentLoginAuthException();
  //       default:
  //         throw OperationErrorAuthException();
  //     }
  //   } catch (e) {
  //     throw OperationErrorAuthException();
  //   }
  // }

  // static Future<void> updateUserPassword(String password) async {
  //   try {
  //     await firebaseAuth.currentUser!.updatePassword(password);
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case 'weak-password':
  //         throw WeakPasswordAuthException();
  //       case 'requires-recent-login':
  //         throw RequiresRecentLoginAuthException();
  //       default:
  //         throw OperationErrorAuthException();
  //     }
  //   } catch (e) {
  //     throw OperationErrorAuthException();
  //   }
  // }

  static Future<void> register(
      String name, String email, String password) async {
    try {
      final signInResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (signInResult.user != null) {
        await updateUserDisplayName(name);
        final docRef = await firestore.collection('customers').add({
          'name': name,
          'email': email,
        });
        await firestore
            .collection('customers')
            .doc(docRef.id)
            .update({'customer_id': firebaseAuth.currentUser!.uid});
      } else {
        //TODO add auth exeptions
        throw OperationErrorAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw InvalidEmailAuthException();
        case 'email-already-in-use':
          throw EmailAlreadyInUseAuthException();
        case 'operation-not-allowed':
          throw OperationNotAllowedAuthException();
        case 'weak-password':
          throw WeakPasswordAuthException();
        default:
          throw OperationErrorAuthException();
      }
    } catch (e) {
      throw OperationErrorAuthException();
    }
  }

  static Future<void> logout() async {
    try {
      // CacheManager.setValue(userIsLoggedInCacheKey, false);
      // CacheManager.setValue(userNameCacheKey, '');
      // CacheManager.setValue(userIdCacheKey, '');
      // CacheManager.setValue(userEmailCacheKey, '');
      // CacheManager.setValue(userProfileImgUrlCacheKey, '');
      // CacheManager.setValue(userPasswordCacheKey, '');
      // CacheManager.setValue(userBioCacheKey, '');
      // AppConstants.userIsLoggedIn = false;
      // AppConstants.userName = '';
      // AppConstants.userId = '';
      // AppConstants.userEmail = '';
      // AppConstants.userProfileImgUrl = '';
      // AppConstants.userPassword = '';
      // AppConstants.userBio = '';
      await firebaseAuth.signOut();
    } catch (e) {
      throw OperationErrorAuthException();
    }
  }

  static Future<bool> employee_login(String email, String password) async {
    try {
      final credential = await firestore
          .collection("employees")
          .where('email', isEqualTo: email)
          .get();
      if (credential.docs.first.data()["password"] == password) {
        return true;
      } else {
        return false;
      }

      // log(credential.docs.first.data().toString());
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  static Future<bool> driver_login(String email, String password) async {
    try {
      final credential = await firestore
          .collection("drivers")
          .where('email', isEqualTo: email)
          .get();
      if (credential.docs.first.data()["password"] == password) {
        CacheManager.setValue('driverId', credential.docs.first.id);
        AppConstants.driverId = credential.docs.first.id;
        return true;
      } else {
        return false;
      }

      // log(credential.docs.first.data().toString());
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
