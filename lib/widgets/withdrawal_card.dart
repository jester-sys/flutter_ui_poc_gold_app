import 'package:flutter/material.dart';

class WithdrawalCard extends StatelessWidget {
  final double amount;
  final String method;
  final String provider;
  final String account;
  final String id;
  final double fee;
  final String date;
  final String status;

  const WithdrawalCard({
    super.key,
    required this.amount,
    required this.method,
    required this.provider,
    required this.account,
    required this.id,
    required this.fee,
    required this.date,
    required this.status,
  });

  Color getStatusColor(BuildContext context) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF4CAF50);
      case 'Processing':
        return Colors.orange[700]!;
      case 'Failed':
        return Theme.of(context).colorScheme.error;
      default:
        return Colors.grey;
    }
  }

  Color getIconBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (status) {
      case 'Completed':
        return isDark ? const Color(0xFF1B3A1B) : const Color(0xFFE8F5E9);
      case 'Processing':
        return isDark ? const Color(0xFF3A3020) : const Color(0xFFFFF3E0);
      case 'Failed':
        return isDark ? const Color(0xFF3A1B1B) : const Color(0xFFFFEBEE);
      default:
        return isDark ? Colors.grey[800]! : Colors.grey[200]!;
    }
  }

  IconData get statusIcon {
    switch (status) {
      case 'Completed':
        return Icons.check;
      case 'Processing':
        return Icons.access_time;
      case 'Failed':
        return Icons.error_outline;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.brightness == Brightness.light
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusIcon(context),
          const SizedBox(width: 16),
          _buildTransactionDetails(context),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: getIconBackgroundColor(context),
        shape: BoxShape.circle,
      ),
      child: Icon(
        statusIcon,
        color: getStatusColor(context),
        size: 24,
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndAmount(context),
          const SizedBox(height: 8),
          _buildMethodProvider(context),
          const SizedBox(height: 12),
          _buildBottomRow(context),
        ],
      ),
    );
  }

  Widget _buildTitleAndAmount(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Withdrawal',
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '-\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: theme.colorScheme.error,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMethodProvider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      '$method • $provider - $account',
      style: TextStyle(
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        fontSize: 13,
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIdAndFee(context),
        _buildDateAndStatus(context),
      ],
    );
  }

  Widget _buildIdAndFee(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          id,
          style: TextStyle(
            color: isDark ? Colors.grey[600] : Colors.grey[500],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Fee: \$${fee.toStringAsFixed(2)}',
          style: TextStyle(
            color: isDark ? Colors.grey[600] : Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndStatus(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          date,
          style: TextStyle(
            color: isDark ? Colors.grey[600] : Colors.grey[500],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final statusColor = getStatusColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor,
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}