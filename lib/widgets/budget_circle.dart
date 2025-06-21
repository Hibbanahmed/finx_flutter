import 'package:flutter/material.dart';

class BudgetCircle extends StatelessWidget {
  final double balance;

  const BudgetCircle({super.key, this.balance = 0.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.deepPurple,
        child: Text(
          '₹${balance.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
