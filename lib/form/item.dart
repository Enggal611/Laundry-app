import 'package:flutter/material.dart';

import 'detail.dart';

class ItemCard extends StatefulWidget {
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

  const ItemCard({
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
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool cekList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Card(
        elevation: 1,
        color: Color.fromARGB(255, 240, 240, 240),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(
                          id: widget.id,
                          nama: widget.nama,
                          alamat: widget.alamat,
                          tgl: widget.tgl,
                          berat: widget.berat,
                          telp: widget.telp,
                          status: widget.status,
                          total: widget.total,
                          diambil: widget.diambil,
                          gbr: widget.gbr,
                          bayar: widget.bayar,
                          selesai: widget.selesai,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text('Nama Cust ',
                              style: TextStyle(fontSize: 17)),
                        ),
                        Text(" : "),
                        Text(
                          widget.nama,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text('Alamat', style: TextStyle(fontSize: 17)),
                        ),
                        Text(' : '),
                        Text(widget.alamat,
                            style: TextStyle(
                              fontSize: 17,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child:
                              Text('Tanggal', style: TextStyle(fontSize: 17)),
                        ),
                        Text(' : '),
                        Text(widget.tgl,
                            style: TextStyle(
                              fontSize: 17,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child:
                              Text('Status ', style: TextStyle(fontSize: 17)),
                        ),
                        Text(' : '),
                        Text(widget.status,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.greenAccent[400],
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
