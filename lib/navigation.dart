import 'package:exam_ai/controllers/navigation_controller.dart';
import 'package:exam_ai/screens/main/analytics/analytics.dart';
import 'package:exam_ai/screens/main/home/home.dart';
import 'package:exam_ai/screens/main/profile/profile.dart';
import 'package:exam_ai/screens/main/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final NavController navController = Get.put(NavController());

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[navController.selectedIndex.value]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Obx(
              () => BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
            currentIndex: navController.selectedIndex.value,
            onTap: navController.updateIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedItemColor: Colors.deepPurple, // Seçili ikon rengi
            unselectedItemColor: Colors.grey, // Seçili olmayan ikon rengi
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Soru Ekleme"),
              content: Text("Çok yakında siz de soru ekleyebilirsiniz."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Kapat"),
                )
              ],
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.qr_code_scanner, size: 28), // Orta ikonu
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
