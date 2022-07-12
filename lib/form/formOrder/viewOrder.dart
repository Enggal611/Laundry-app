import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'readOrder.dart';

class viewOrder extends StatefulWidget {
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

  const viewOrder({
    Key? key,
    required this.id,
    required this.nama,
    required this.tgl,
    required this.gbr,
    required this.berat,
    required this.telp,
    required this.status,
    required this.total,
    required this.diambil,
    required this.alamat,
    required this.bayar,
    required this.selesai,
  }) : super(key: key);

  @override
  _viewOrderState createState() => _viewOrderState();
}

class _viewOrderState extends State<viewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesanan"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(MaterialPageRoute(builder: (_) => readOrder()));
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
                                padding: const EdgeInsets.all(5),
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
                                color: Colors.greenAccent[400],
                                fontWeight: FontWeight.bold),
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
                        height: 8,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Foto Pesanan Cucian',
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
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
