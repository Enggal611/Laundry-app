import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../form/formOrder/order.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  final currentUser = FirebaseAuth.instance;

  final gambar = [
    'image/banner1.png',
    'image/banner2.png',
    'image/banner3.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(children: [
          Positioned.fill(
              top: 250,
              child: Container(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.white])),
                ),
              )),
          Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("akun")
                      .where("uid", isEqualTo: currentUser.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, item) {
                            var data = snapshot.data!.docs[item];
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 15, bottom: 10),
                                  child: Text(
                                    'Selamat Datang, ' + data['nama'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            'Data Tidak Ada',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                        ],
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
                child: CarouselSlider(
                  items: gambar.map(
                    (img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(img),
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: GridView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => order()));
                      },
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 8,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/logo.png',
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Wash & Dry',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Pemberitahuan'),
                            content: Text(
                              'Menu Sedang Dalam Pengembangan!',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 8,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/dry.png',
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Dry',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Pemberitahuan'),
                            content: Text(
                              'Menu Sedang Dalam Pengembangan!',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 8,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/setrika.png',
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Iron',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Pemberitahuan'),
                            content: Text(
                              'Menu Sedang Dalam Pengembangan!',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 8,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/satuan.png',
                              height: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Cuci Satuan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
