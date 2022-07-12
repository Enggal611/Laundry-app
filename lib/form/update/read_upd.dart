import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../admin/adminPage.dart';
import 'view_upd.dart';

class readUpd extends StatefulWidget {
  @override
  _readUpdState createState() => _readUpdState();
}

class _readUpdState extends State<readUpd> {
  String nama = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Update Pesanan"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => adminPage(
                        id: '',
                        nama: '',
                        umur: '',
                        tgl: '',
                        gbr: '',
                      )));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Cari Nama Pelanggan...",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search_rounded,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          nama = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: (nama != " " && nama != null)
                        ? FirebaseFirestore.instance
                            .collection("cust")
                            .where("nama", isGreaterThanOrEqualTo: nama)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('cust')
                            .orderBy('tanggal', descending: true)
                            .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Tidak ada Data');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Text('Loading'));
                      }
                      return Column(
                        children: snapshot.data!.docs
                            .map((data) => viewUpd(
                                  id: data.id,
                                  nama: data['nama'],
                                  tgl: data['tanggal'],
                                  gbr: data['gambar'],
                                  alamat: data['alamat'],
                                  berat: data['berat'],
                                  diambil: data['diambil'],
                                  status: data['status'],
                                  telp: data['telepon'],
                                  total: data['total'],
                                  bayar: data['pembayaran'],
                                  selesai: data['laundry selesai'],
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
