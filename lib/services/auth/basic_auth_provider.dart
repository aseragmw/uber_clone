import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/cache_manager.dart';

class BasicAuthProvider {
  static BasicAuthProvider? _instance = null;
  static BasicAuthProvider getInstance() {
    if (_instance == null) {
      _instance = BasicAuthProvider();
    }
    return _instance!;
  }

  // BasicAuthProvider._() {}

  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String? verifyId;

  User currentCustomer() {
    return firebaseAuth.currentUser!;
  }

  Future<bool> login(String email, String password) async {
    try {
      final signInResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (signInResult.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserDisplayName(String name) async {
    try {
      await firebaseAuth.currentUser!.updateDisplayName(name);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      log('error updating display name');
      return false;
    }
  }

  Future<bool> updateUserEmail(String email) async {
    try {
      await firebaseAuth.currentUser!.updateEmail(email);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      log('error updating email');
      return false;
    }
  }

  Future<bool> updateUserPassword(String password) async {
    try {
      await firebaseAuth.currentUser!.updatePassword(password);
      return true;
    } catch (e) {
      //TODO add auth exeptions
      log('error updating display name');
      return false;
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          verifyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      log('2 ${verifyId.toString()}');
    } catch (e) {
      //TODO add auth exeptions
      log('error updating phone number');
    }
  }

  Future<bool> confirmOTP(String smsCode) async {
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
  }

  Future<bool> register(String name, String email, String password) async {
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
        return true;
      } else {
        //TODO add auth exeptions
        return false;
      }
    }
    
    catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> employeeLogin(String email, String password) async {
    try {
      final res = await firestore
          .collection("employees")
          .where('email', isEqualTo: email)
          .get();
      if (res.docs.first.data()["password"] == password) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> driverLogin(String email, String password) async {
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
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
