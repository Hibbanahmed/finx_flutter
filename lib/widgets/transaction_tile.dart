import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final int amount;
  final String category;
  final String date;
  final String source;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.source,
  });

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Choose a Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text('Food'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Travel'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Shopping'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Other'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showCategoryPicker(context),
      leading: const Icon(Icons.account_balance_wallet),
      title: Text(title),
      subtitle: Text('$category • $date\n$source'),
      trailing: Text(
        '- ₹$amount',
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
