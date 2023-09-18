import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

import '../aes_encryption.dart';
import '../file_storage.dart';

class CekPage extends StatelessWidget {
  const CekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Page"),
      ),
      body: BodyCekPage(),
    );
  }
}

class BodyCekPage extends StatefulWidget {
  const BodyCekPage({super.key});

  @override
  State<BodyCekPage> createState() => _BodyCekPageState();
}

class _BodyCekPageState extends State<BodyCekPage> {
  final FileStorage storage = FileStorage();
  AESEncryption encryption = new AESEncryption();
  var datafile = "";
  var decryptdatafile = "";
  bacadatafile() {
    storage.readResult().then((value) {
      setState(() {
        datafile = value.toString();
        print(value);
        // 3519bff05c7be10f7927ecf219dab3c8153dd014bad691f16de66999abcec7ad
        decryptdatafile = encryption.decryptMsg(encryption.getCode(datafile));
        // List mmm = jsonDecode(decryptdatafile);
        // print(mmm.length);
        // print(mmm[0]['data']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              bacadatafile();
            },
            child: Text("BACA")),
        Card(
          child: Column(
            children: [Text("Data encripted :"), Text("${datafile}")],
          ),
        ),
        Card(
          child: Column(
            children: [Text("Data decripted :"), Text("${decryptdatafile}")],
          ),
        ),
      ],
    ));
  }
}
