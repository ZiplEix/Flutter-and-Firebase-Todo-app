import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final ImagePicker picker = ImagePicker();
  late XFile image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(),
                  IconButton(
                    onPressed: () async {
                      image = (await picker.pickImage(
                          source: ImageSource.gallery))!;
                      setState(() {
                        image = image;
                      });
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.teal,
                      size: 30,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image.path));
    } else {
      return const AssetImage("assets/rocket.png");
    }
  }

  Widget button() {
    return InkWell(
      onTap: () async {},
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Add Todo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
