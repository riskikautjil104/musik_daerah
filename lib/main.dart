import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:musik_daerah/view/musik.dart';
// import 'package:musik_daerah/view/suka.dart';
// import 'package:musik_daerah/controller/bottom_nav_controller.dart';
// import 'package:musik_daerah/view/home.dart';
// import 'package:musik_daerah/view/musik.dart';
// import 'package:musik_daerah/view/suka.dart';
// import 'package:musik_daerah/widget/musik_player.dart';

import 'widget/buttonbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      title: 'Musik Malut App',
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (_) => const MainPage(),
      //   '/musik': (_) => const Musik(),
      //   '/suka': (_) => const Suka(),
      // },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Color(0xFFF0A071E),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

