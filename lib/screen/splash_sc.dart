import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../user/botnav.dart';
import 'login_sc.dart';

class splash_sc extends StatefulWidget {
  const splash_sc({Key? key}) : super(key: key);

  @override
  State<splash_sc> createState() => _splash_scState();
}

class _splash_scState extends State<splash_sc> {
  startTimer() async {
    var durasi = Duration(seconds: 3);
    return Timer(durasi, () async {
      var box = Hive.box('user');
      bool? sudahLogin = box.get('isLogin');

      if (sudahLogin ?? false) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Nav()));
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => login_screen()),
        );
      }

      // if (sudahLogin ?? false) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (_) => adminPage(
      //       id: '',
      //       nama: '',
      //       umur: '',
      //       tgl: '',
      //       gbr: '',
      //     )),
      //   );
      // } else if (sudahLogin ?? false) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (_) => userPage()),
      //   );
      // }
      // else {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (_) => login_screen()),
      //   );
      // }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("image/1.png", height: 150, width: 150),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
