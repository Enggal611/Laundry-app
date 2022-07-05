import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../form/formOrder/itemOrder.dart';

class pending extends StatefulWidget {
  const pending({Key? key}) : super(key: key);

  @override
  State<pending> createState() => _pendingState();
}

class _pendingState extends State<pending> {
  final user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On Procces"),
      ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cust')
                  .where("email", isEqualTo: user.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading'));
                }
                return Column(children: [
                  Expanded(child: pending(snapshot)),
                ]);
              }),
        )
          );
  }

  Widget pending(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    var allData = snapshot.data?.docs;
    allData = allData?.where((element) {
      return element['status'] == 'Sedang Diproses';
    }).toList();

    return ListView.builder(
      itemCount: allData?.length,
      itemBuilder: (context, index) => Card(
        child: itemOrder(
          id: allData?[index].id?? '',
          nama: allData?[index]['nama'],
          tgl: allData?[index]['tanggal'],
          gbr: allData?[index]['gambar'],
          alamat: allData?[index]['alamat'],
          berat: allData?[index]['berat'],
          diambil: allData?[index]['diambil'],
          status: allData?[index]['status'],
          telp: allData?[index]['telepon'],
          total: allData?[index]['total'],
          bayar: allData?[index]['pembayaran'],
          selesai: allData?[index]['laundry selesai'],
        ),
      ),

    );
  }
}
