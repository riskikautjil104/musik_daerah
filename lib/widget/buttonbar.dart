import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musik_daerah/controller/bottom_nav_controller.dart';

import '../view/home.dart';
import '../view/musik.dart';
import '../view/suka.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.put(BottomNavController());

    final List<Widget> _widgetOptions = [
      const Home(),
      const Musik(),
      const Suka(),
    ];

    return Scaffold(
      body: Obx(() => _widgetOptions[bottomNavController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF0A091E),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note, color: Colors.white),
                label: 'Musik',
              ),
              BottomNavigationBarItem(
                
                icon: Icon(Icons.favorite_border_outlined, color: Colors.white,),
                label: 'Suka',
                
              ),
            ],
            currentIndex: bottomNavController.selectedIndex.value,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.white,
            onTap: bottomNavController.changeIndex,
          ),
        ),
      )),
    );
  }
}
