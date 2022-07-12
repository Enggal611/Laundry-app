import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'read_del.dart';

class Delete extends StatefulWidget {
  final String id,
      nama,
      tgl,
      gbr,
      berat,
      telp,
      status,
      total,
      diambil,
      bayar,
      selesai,
      alamat;

  const Delete({
    Key? key,
    required this.id,
    required this.nama,
    required this.berat,
    required this.telp,
    required this.status,
    required this.total,
    required this.diambil,
    required this.alamat,
    required this.tgl,
    required this.gbr,
    required this.bayar,
    required this.selesai,
  }) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  hapusData() async {
    FirebaseFirestore.instance.collection("cust").doc(widget.id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Data Berhasil Dihapus")));

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => readDel()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Pesanan"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => readDel()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                color: Color.fromARGB(255, 240, 240, 240),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Nama Cust ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.nama}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Alamat  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: Text(
                                      "${widget.alamat}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Telepon ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.telp}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Tanggal  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.tgl}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Berat (Kg)',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.berat}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Total  ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.total}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              'Pembayaran  ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.bayar}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 140,
                              child: Text(
                                'Status ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.status}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent[400]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              'Pengiriman',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.diambil}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              'Pesanan Selesai',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(' : ',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(
                            "${widget.selesai}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 300,
                              child: Text(
                                'Pesanan Cucian Selesai',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${widget.gbr}",
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Hapus Pesanan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        onPressed: hapusData,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
