import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'file_storage.dart';
import 'result_screen.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: ImageFile(),
      )),
    );
  }
}

class ImageFile extends StatefulWidget {
  const ImageFile({super.key});

  @override
  State<ImageFile> createState() => _ImageFileState();
}

class _ImageFileState extends State<ImageFile> {
  var foto;
  var fotoPath;
  final textRecognizer = TextRecognizer();
  var recotext;

  Future pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      final inputImage = InputImage.fromFile(File(image!.path));
      final recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        fotoPath = image!.path;
        foto = File(fotoPath);
        recotext = recognizedText.text;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Text("get image")),
                (foto != null)
                    ? Column(
                        children: [
                          // Text(fotoPath),
                          Image.file(
                            foto,
                            fit: BoxFit.cover,
                          ),
                          // Text(recotext),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                          text: recotext,
                                          storage: FileStorage()),
                                    ));
                              },
                              child: Text("result"))
                        ],
                      )
                    : const Text("blm ada image"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
