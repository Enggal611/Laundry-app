import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../admin/adminPage.dart';
import '../auth/auth.dart';
import '../user/botnav.dart';
import 'signUp.dart';

class login_screen extends StatefulWidget {
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePass = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("image/1.png")),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue[700]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username or Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  obscureText: hidePass,
                  controller: password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open_outlined),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('Hide Password=$hidePass');
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      icon: Icon(
                          hidePass ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Fitur Dalam Pengembangan')));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                loading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text('Mohon Tunggu')));

                            String res = await auth().Login(
                              email.text,
                              password.text,
                            );
                            if (res == 'Berhasil') {
                              bool Admin = await auth().checkAdmin();
                              if (Admin) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (_) => adminPage(
                                              id: '',
                                              nama: '',
                                              umur: '',
                                              tgl: '',
                                              gbr: '',
                                            )));

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Berhasil Login')));
                              } else if (!Admin) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => Nav()));
                                var box = Hive.box('user');
                                box.put('isLogin', true);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Berhasil Login')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Username/ Password Salah")));
                            }

                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                            style:
                                TextButton.styleFrom(primary: Colors.blue[700]),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => sign_up()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
