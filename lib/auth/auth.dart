import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class auth {
  Future<String> Login(String email, String password) async {
    String res = '';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = 'Berhasil';
    } catch (e) {
      res = 'Gagal';
    }
    return res;
  }

  Future<bool> checkAdmin() async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('akun')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    DocumentSnapshot snapshot = await reference.get();
    bool checkAdmin = await snapshot.get('Admin');
    return checkAdmin;
  }

  Future getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }
}
