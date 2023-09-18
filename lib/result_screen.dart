import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/aes_encryption.dart';
import 'package:flutter_text_recognition/database_helper.dart';

import 'file_storage.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.text, required this.storage});
  final String text;
  final FileStorage storage;

  @override
  Widget build(BuildContext context) {
    AESEncryption encryption = new AESEncryption();
    List datanya = text.split("");
    String calculator = "";
    String hasil = "";
    if (datanya.length > 2) {
      calculator = datanya[0] + datanya[1] + datanya[2];
      if (datanya[1] == "+") {
        hasil = (int.parse(datanya[0]) + int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) + int.parse(datanya[2]));
      } else if (datanya[1] == "-") {
        hasil = (int.parse(datanya[0]) - int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) - int.parse(datanya[2]));
      } else if (datanya[1] == "x") {
        hasil = (int.parse(datanya[0]) * int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) * int.parse(datanya[2]));
      } else if (datanya[1] == "/") {
        hasil = (int.parse(datanya[0]) / int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) / int.parse(datanya[2]));
      } else {
        hasil = "no defined";
        // print("no defined");
      }
      // file storage
      // cek file
      storage.cekFile().then((value) {
        //read file value true jika ada file nya
        if (value) {
          storage.readResult().then((data) {
            String kodok =
                encryption.decryptMsg(encryption.getCode(data.toString()));
            var wow = jsonDecode(kodok);
            // var wow = jsonDecode(data.toString());
            List datanya = [
              {"data": calculator, "hasil": hasil}
            ];
            // tambah list data
            datanya.addAll(wow);
            var result = jsonEncode(datanya);
            var encryptedResult =
                encryption.encryptMsg(result.toString()).base16;
            storage.writeResult(encryptedResult);
            print(result);
          });
        } else {
          List datanya = [
            {"data": calculator, "hasil": hasil}
          ];
          var result = jsonEncode(datanya);
          var encryptedResult = encryption.encryptMsg(result.toString()).base16;
          storage.writeResult(encryptedResult);
        }
      });

      //create histori
      DatabaseHelper.createHistory(calculator, hasil);
      DatabaseHelper.getHistories().then((value) {
        print(value);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.all(30.0),
          //   child: Text("${text}"),
          // ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Text("calculator : ${calculator} = ${hasil}"),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       print(datanya.toString());
          //       if (datanya[1] == "+") {
          //         print(int.parse(datanya[0]) + int.parse(datanya[2]));
          //       } else if (datanya[1] == "-") {
          //         print(int.parse(datanya[0]) - int.parse(datanya[2]));
          //       } else if (datanya[1] == "x") {
          //         print(int.parse(datanya[0]) * int.parse(datanya[2]));
          //       } else if (datanya[1] == "/") {
          //         print(int.parse(datanya[0]) / int.parse(datanya[2]));
          //       } else {
          //         print("no defined");
          //       }
          //     },
          //     child: Text("test")),
        ],
      ),
    );
  }
}
