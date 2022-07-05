
import 'package:flutter/material.dart';

import 'delete.dart';

class viewDel extends StatelessWidget {
  final String  id, 
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

  const viewDel({
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => Delete(
            id: id,
            nama: nama,
            tgl: tgl,
            gbr: gbr, 
            alamat: alamat, 
            berat: berat, 
            diambil: diambil, 
            status: status, 
            telp: telp, 
            total: total,
            bayar: bayar,
            selesai: selesai,
          )));
        },
        
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text('Nama Cust',
                      style: TextStyle(fontSize: 20)),
                    ),
                    Text(' : '),
                    Text(nama,
                    style: TextStyle(fontSize: 20),),
                  ],
                ),

                Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text('Alamat',
                          style: TextStyle(fontSize: 17)),
                        ),
                        Text(' : '),
                        Text(alamat,
                        style: TextStyle(fontSize: 17,
                        )),
                      ],
                    ),
    
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text('Tanggal',
                      style: TextStyle(fontSize: 20)),
                    ),
                    Text(' : '),
                    Text(tgl,
                    style: TextStyle(fontSize: 20)),
                  ],
                ),
    
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text('Status ',
                      style: TextStyle(fontSize: 20)),
                    ),
                    Text(' : '),
                    Text(status,
                    style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent[400])),
                  ],
                ),
                
                ],
                
            ),
          ),
        ),
      ),
    );
  }
}