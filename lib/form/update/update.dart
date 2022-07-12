import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'read_upd.dart';

class Update extends StatefulWidget {
  final String id,
      nama,
      tgl,
      berat,
      telp,
      status,
      total,
      diambil,
      bayar,
      selesai,
      alamat;

  const Update({
    Key? key,
    required this.id,
    required this.nama,
    required this.tgl,
    required String gambar,
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
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final txtNama = TextEditingController();
  final txtUmur = TextEditingController();
  final txtTgl = TextEditingController();
  final txtAlamat = TextEditingController();
  final txtBerat = TextEditingController();
  final txtStatus = TextEditingController();
  final txtDiambil = TextEditingController();
  final txtTotal = TextEditingController();
  final txtTelp = TextEditingController();
  final txtBayar = TextEditingController();
  final txtSelesai = TextEditingController();

  setup() {
    txtNama.text = widget.nama;
    txtTgl.text = widget.tgl;
    txtAlamat.text = widget.alamat;
    txtBerat.text = widget.berat;
    txtStatus.text = widget.status;
    txtDiambil.text = widget.diambil;
    txtTotal.text = widget.total;
    txtTelp.text = widget.telp;
    txtBayar.text = widget.bayar;
    txtSelesai.text = widget.selesai;
  }

  void simpanUpdate() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cust = firestore.collection("cust");
    final showImage = await uploadFile();

    await cust.doc(widget.id).update({
      "nama": txtNama.text,
      "tanggal": txtTgl.text,
      "alamat": txtAlamat.text,
      "telp": txtTelp.text,
      "berat": txtBerat.text,
      "status": txtStatus.text,
      "total": txtTotal.text,
      "diambil": txtDiambil.text,
      "pembayaran": txtBayar.text,
      "laundry selesai": txtSelesai.text,
      "gambar": showImage,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Data Selesai di Edit")));
    });
  }

  //FOTO

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    String show;
    String fname = DateTime.now().toString();
    Reference reff = FirebaseStorage.instance.ref().child('files/$fname');

    await reff.putFile(_photo!);

    show = await reff.getDownloadURL();
    return show;
  }

  //END

  String dropStatus = 'Pilih Status';
  var data = [
    'Pilih Status',
    'Sedang Diproses',
    'Selesai',
  ];

  @override
  void initState() {
    super.initState();
    setup();
  }

  //VALIDATION
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Pesanan"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => readUpd()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtNama,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nama",
                            labelText: "Nama Lengkap"),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          readOnly: true,
                          controller: txtAlamat,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Alamat",
                              labelText: "Alamat"),
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtTelp,
                        decoration: InputDecoration(
                            hintText: "Telepon", labelText: "Telepon"),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtTgl,
                        decoration: InputDecoration(
                            hintText: "Tanggal", labelText: "Tanggal"),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtBerat,
                        decoration: InputDecoration(
                            hintText: "Berat Cucian 'kg'",
                            labelText: "Berat Cucian 'kg'"),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtTotal,
                        decoration: InputDecoration(
                            hintText: "Total Bayar", labelText: "Total Bayar"),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtBayar,
                        decoration: InputDecoration(
                            hintText: "Pembayaran COD only",
                            labelText: "Pembayaran"),
                      ),
                    ),
                  ),
                ),

                //STATUS
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        'Status Laundry',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: Card(
                          color: Color.fromARGB(255, 240, 240, 240),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(1),
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dropStatus,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: data.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      items,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? data) {
                                setState(() {
                                  dropStatus = data!;
                                  txtStatus.text = data;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtStatus,
                        decoration: InputDecoration(
                          hintText: "Status",
                          labelText: "Status",
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtDiambil,
                        decoration: InputDecoration(labelText: "Pengiriman"),
                      ),
                    ),
                  ),
                ),

                Card(
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
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      controller: txtSelesai,
                      decoration: InputDecoration(labelText: "Pesanan Selesai"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    'Bukti Pesanan Selesai',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Gambar Harus Diisi !',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),

                //IMAGE
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 240, 240, 240),
                        border: Border.all(color: Colors.blue)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: _photo != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _photo!,
                                      height: 200,
                                      width: 240,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 150,
                                  height: 150,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Update Pesanan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      simpanUpdate();

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => readUpd()));
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
