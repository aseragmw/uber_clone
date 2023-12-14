import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone_app/services/auth/auth_exceptions.dart';

class BasicAuthProvider {
  static final firebaseAuth = FirebaseAuth.instance;
  static String? verifyId;
  static Future<void> login(String email, String password) async {
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
        log('akher login function');
      } else {
        throw OperationErrorAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw InvalidEmailAuthException();
        case 'user-disabled':
          throw UserDisabledAuthException();
        case 'user-not-found':
          throw UserNotFoundAuthException();
        case 'wrong-password':
          throw WrongPasswordAuthException();
        default:
          throw OperationErrorAuthException();
      }
    } catch (e) {
      throw OperationErrorAuthException();
    }
  }

  static Future<void> updateUserDisplayName(String name) async {
    try {
      await firebaseAuth.currentUser!.updateDisplayName(name);
    } catch (e) {
      //TODO add auth exeptions
      // throw OperationErrorAuthException();
      log('error updating display name');
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

      // Sign the user in (or link) with the credential
      await firebaseAuth.currentUser!.updatePhoneNumber(credential);
      return true;
    } catch (ex) {
      log(ex.toString());
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
        // return signInResult;
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
}
