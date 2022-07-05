import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'itemOrder.dart';

class readOrder extends StatefulWidget {
  @override
  _readOrderState createState() => _readOrderState();
}

class _readOrderState extends State<readOrder> {

  final user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Pesanan"),
      ),
      body: SafeArea(
        child: Stack(children: [
          Positioned.fill(
            bottom: 350,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: StreamBuilder<QuerySnapshot>(
              stream:

                  FirebaseFirestore.instance
                  .collection('cust')
                  .where("email", isEqualTo: user.currentUser!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Tidak ada Data');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading'));
                }
                return Column(children: [
              Expanded(child: pending(snapshot)),
            ]);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget pending(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    var allData = snapshot.data?.docs;
    allData = allData?.where((element) {
      return element['status'] == 'Selesai';
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
