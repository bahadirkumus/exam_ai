import 'package:get/get.dart';

class NavController extends GetxController {
  // Seçilen indeks değeri
  var selectedIndex = 0.obs;

  // İndeks güncelleme fonksiyonu
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
