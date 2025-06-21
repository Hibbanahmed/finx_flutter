import 'package:flutter/material.dart';
import 'package:finx_v1/widgets/budget_circle.dart';
import 'package:finx_v1/widgets/category_tile.dart';
import 'package:finx_v1/widgets/transaction_tile.dart';
import 'package:finx_v1/services/sms_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'spent': 2200, 'total': 5000},
    {'name': 'Travel', 'spent': 1500, 'total': 3000},
    {'name': 'Shopping', 'spent': 800, 'total': 2000},
  ];

  final List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    SMSService.startListening(_handleNewTransaction);
  }

  void _handleNewTransaction(Map<String, dynamic> txn) async {
    String? selectedCategory = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('₹${txn['amount']} debited'),
          content: Text(
            'What category should this go to?\n(${txn['merchant']})',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Food'),
              child: const Text('Food'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Travel'),
              child: const Text('Travel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Shopping'),
              child: const Text('Shopping'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Other'),
              child: const Text('Other'),
            ),
          ],
        );
      },
    );

    if (selectedCategory != null) {
      setState(() {
        transactions.insert(0, {
          'title': txn['merchant'],
          'amount': txn['amount'].round(),
          'category': selectedCategory,
          'date': txn['date'],
          'source': 'SMS',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinX Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BudgetCircle(),
            const SizedBox(height: 24),
            const Text(
              'Spending Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories
                    .map(
                      (cat) => CategoryTile(
                        name: cat['name'],
                        spent: cat['spent'],
                        total: cat['total'],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...transactions
                .map(
                  (txn) => TransactionTile(
                    title: txn['title'],
                    amount: txn['amount'],
                    category: txn['category'],
                    date: txn['date'],
                    source: txn['source'],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
