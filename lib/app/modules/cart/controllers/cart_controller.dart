import 'package:get/get.dart';

class CartController extends GetxController {
  //TODO: Implement CartController
  var selectedIds = <String>{}.obs;

  final cartItems = <Map<String, dynamic>>[
    // {
    //   'id' : '1',
    //   'title' : "Men’s Sport Physique",
    //   'price' : 500000,
    //   'pricelabel' : 'Rp. 500.000',
    //   'image' : 'assets/image/class1.png',
    // },
    // {
    //   'id' : '2',
    //   'title' : "Men’s Fitness Open",
    //   'price' : 300000,
    //   'pricelabel' : 'Rp. 300.000',
    //   'image' : 'assets/image/class1.png',
    // },
    // {
    //   'id' : '3',
    //   'title' : "Local Javanese Strength",
    //   'price' : 250000,
    //   'pricelabel' : 'Rp. 250.000',
    //   'image' : 'assets/image/class1.png',
    // },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    selectedIds.add('1');
  }

  void toggleItem(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }

  bool isSelected(String id) => selectedIds.contains(id);

  // Hitung total harga item yang dipilih
  int get totalPrice {
    return cartItems
        .where((item) => selectedIds.contains(item['id']))
        .fold(0, (sum, item) => sum + (item['price'] as int));
  }

  String get totalPriceLabel {
    final total = totalPrice;
    // Format: Rp. 500.000
    final formatted = total.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp. $formatted';
  }

  // Hapus item yang dipilih
  void deleteSelected() {
    cartItems.removeWhere((item) => selectedIds.contains(item['id']));
    selectedIds.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
