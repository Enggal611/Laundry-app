import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../admin/adminPage.dart';
import 'item.dart'; 

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  String nama = " ";
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data"),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: 
              Card(
                elevation: 7,
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
                    style: TextStyle(
                              fontSize: 18
                            ),
                    decoration: InputDecoration(
                      hintText: "Cari Nama Pelanggan...",
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search_rounded,),
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
                      .collection("cust")
                      .orderBy("tanggal", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : 
                        Column(
                            children: [
                              Column(
                                children: snapshot.data!.docs
                                    .map((data) => Card(
                                          child: ItemCard(
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
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
