import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final double totalWithdrawn;
  final int totalTransactions;
  final int successRate;

  const StatsCard({
    super.key,
    required this.totalWithdrawn,
    required this.totalTransactions,
    required this.successRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange[700]!,
            Colors.orange[600]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Withdrawn', '\$$totalWithdrawn'),
          _buildDivider(),
          _buildStatItem('Total Transactions', '$totalTransactions'),
          _buildDivider(),
          _buildStatItem('Success Rate', '$successRate%'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.orange[900],
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.orange[800],
    );
  }
}