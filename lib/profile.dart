//profile.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  bool _showAvatar = true;

  void _setImage(File? image) {
    setState(() {
      _image = image;
      _showAvatar = false;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      _setImage(File(pickedImage.path));
      Navigator.pop(context);
    }
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          title: const Text(
            'Select Image',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Take Picture', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20 * fem, 80 * fem, 20 * fem, 40 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 150 * fem,
                        height: 150 * fem,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffcc323f),
                            width: 3.0,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showImagePickerDialog(context);
                          },
                          child: SizedBox(
                            width: 150 * fem,
                            height: 150 * fem,
                            child: ClipOval(
                              child: _showAvatar
                                  ? Image.asset(
                                "assets/SeekPng.com_male-symbol-png_410093.png",
                                width: 150 * fem, // Set to fit the container
                                height: 150 * fem, // Set to fit the container
                                fit: BoxFit.cover,
                              )
                                  : _image != null
                                  ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _showImagePickerDialog(context);
                          },
                          child: Container(
                            width: 40 * fem,
                            height: 40 * fem,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffcc323f),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 130),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 56 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffcc323f),
                        borderRadius: BorderRadius.circular(15 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Sk-Modernist',
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700,
                            height: 1.5 * fem / fem,
                            color: const Color(0xffc2cad7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
