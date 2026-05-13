import 'package:get/get.dart';

class TransactionController extends GetxController {
  //TODO: Implement TransactionController

  var selectedFilter = 'All'.obs;

  final filters = ['All', 'Paid', 'Unpaid', 'Canceled'];

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  final List<Map<String, dynamic>> alltransactions = [
    {
      'id': '1',
      'title': 'Men’s Sport Physique',
      'price': 'Rp. 500.000',
      'date': '8 February 2026',
      'status': 'Paid',
    },
    {
      'id': '2',
      'title': 'Men’s Fitness Open',
      'price': 'Rp. 500.000',
      'date': '20 January 2026',
      'status': 'Unpaid',
    },
    {
      'id': '3',
      'title': 'Bodybuilding Over 75 kg',
      'price': 'Rp. 700.000',
      'date': '20 January 2026',
      'status': 'Canceled',
    },
  ];

  // Filter transaksi berdasarkan status
  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedFilter.value == 'All') return alltransactions;
    return alltransactions
        .where((t) => t['status'] == selectedFilter.value)
        .toList();
  }

  // Group transaksi berdasarkan tanggal
  Map<String, List<Map<String, dynamic>>> get groupedTransactions {
    final filtered = filteredTransactions;
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final transaction in filtered) {
      final date = transaction['date'] as String;
      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(transaction);
    }
    return grouped;
  }

}
