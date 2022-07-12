import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_sc.dart';

class sign_up extends StatefulWidget {
  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController alamat = TextEditingController();

  bool hidePass = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("image/signup.png")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //NAMA
                      TextFormField(
                        controller: nama,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: "Nama Lengkap",
                            label: Text('Nama Lengkap'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //TELEPON
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: telp,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_iphone_sharp),
                            hintText: "Nomor Telepon",
                            label: Text('Nomor Telepon'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //ALAMAT
                      TextFormField(
                        controller: alamat,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on_outlined),
                            hintText: "Alamat Lengkap",
                            label: Text('Alamat Lengkap'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //EMAIL
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Email",
                            label: Text('Email'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //PASSWORD
                      TextFormField(
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        obscureText: hidePass,
                        controller: pass,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_open_outlined),
                          hintText: "Password",
                          label: Text('Password Account'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              print('Hide Password=$hidePass');
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                            icon: Icon(hidePass
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
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
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text('Mohon Tunggu')));

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => login_screen()));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 2),
                                          content:
                                              Text('Berhasil Membuat Akun')));

                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: pass.text)
                                      .then((value) {
                                    String res = '';
                                    try {
                                      FirebaseFirestore.instance
                                          .collection('akun')
                                          .doc(value.user!.uid)
                                          .set({
                                        "nama": nama.text,
                                        "telepon": telp.text,
                                        "alamat": alamat.text,
                                        "email": email.text,
                                        "password": pass.text,
                                        "profile": null,
                                        "uid": value.user!.uid,
                                        "Admin": false,
                                      });
                                      res = 'Berhasil';
                                    } catch (e) {
                                      res = e.toString();
                                    }
                                    return res;

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Akun Berhasil Dibuat'),
                                    ));

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                login_screen()));
                                  });

                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),

                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => login_screen()));
                            },
                            child: Text(
                              'Login Here',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue[600]),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
