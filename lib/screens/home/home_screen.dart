import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _requestSmsPermission(); // 🔐 Ask for permission at startup
    _startSmsListener(); // 📡 Listen to SMS via MethodChannel
  }

  /// 🔐 Request SMS runtime permission (Android 6+)
  Future<void> _requestSmsPermission() async {
    final status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }

  /// 📡 Listen to incoming SMS from native Kotlin
  void _startSmsListener() {
    const platform = MethodChannel('com.finx.sms/channel');

    platform.setMethodCallHandler((call) async {
      if (call.method == "onSmsReceived") {
        final smsBody = call.arguments as String;
        _handleIncomingSms(smsBody);
      }
    });
  }

  /// 🧠 Parse and categorize SMS
  void _handleIncomingSms(String sms) async {
    final parsed = parse(sms);

    if (parsed != null) {
      String? category = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("₹${parsed['amount']} debited"),
          content: Text("Assign to category: ${parsed['merchant']}?"),
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
        ),
      );

      if (category != null) {
        setState(() {
          transactions.add({
            'title': parsed['merchant'],
            'amount': parsed['amount'],
            'category': category,
            'date': parsed['date'],
            'source': 'SMS',
          });
        });
      }
    }
  }

  /// 🖼️ Main UI layout
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
            ...transactions.map(
              (txn) => TransactionTile(
                title: txn['title'],
                amount: txn['amount'],
                category: txn['category'],
                date: txn['date'],
                source: txn['source'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
