import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String name;
  final int spent;
  final int total;

  const CategoryTile({
    super.key,
    required this.name,
    required this.spent,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (spent / total).clamp(0.0, 1.0);

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey.shade300,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 4),
          Text('₹$spent / ₹$total'),
        ],
      ),
    );
  }
}
