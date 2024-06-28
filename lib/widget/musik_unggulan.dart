import 'package:flutter/material.dart';

import '../models/musik_unggulan_model.dart';



class Musik_Unggulan extends StatelessWidget {
  final MusikModel musik;

  const Musik_Unggulan({
    super.key,
    required this.musik,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(musik.imagePath), // Menggunakan imagePath dari model
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black.withOpacity(
                  0.5), // Opacity untuk latar belakang teks
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                musik.title, // Menggunakan title dari model
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
