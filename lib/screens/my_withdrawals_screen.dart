import 'package:flutter/material.dart';
import '../widgets/withdrawal_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/filter_chip_widget.dart';
import '../data/withdrawal_data.dart';
import 'notifications_screen.dart';

class MyWithdrawalsScreen extends StatefulWidget {
  const MyWithdrawalsScreen({super.key});

  @override
  State<MyWithdrawalsScreen> createState() => _MyWithdrawalsScreenState();
}

class _MyWithdrawalsScreenState extends State<MyWithdrawalsScreen> {
  String selectedFilter = 'All';

  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedFilter == 'All') {
      return WithdrawalData.allTransactions;
    }
    return WithdrawalData.allTransactions
        .where((t) => t['status'] == selectedFilter)
        .toList();
  }

  double get totalWithdrawn {
    return WithdrawalData.allTransactions
        .where((t) => t['status'] == 'Completed')
        .fold(0.0, (sum, t) => sum + t['amount']);
  }

  int get successRate {
    final completed = WithdrawalData.allTransactions
        .where((t) => t['status'] == 'Completed')
        .length;
    return ((completed / WithdrawalData.allTransactions.length) * 100).round();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme, isDark),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            StatsCard(
              totalWithdrawn: totalWithdrawn,
              totalTransactions: WithdrawalData.allTransactions.length,
              successRate: successRate,
            ),
            const SizedBox(height: 24),
            _buildFilterTabs(),
            const SizedBox(height: 20),
            _buildTransactionsList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, bool isDark) {
    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: isDark ? 0 : 1,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: theme.appBarTheme.iconTheme?.color,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'My Withdrawals',
        style: theme.appBarTheme.titleTextStyle,
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: theme.appBarTheme.iconTheme?.color,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['All', 'Completed', 'Processing', 'Failed'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChipWidget(
              label: filter,
              isSelected: selectedFilter == filter,
              onTap: () => _onFilterChanged(filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: filteredTransactions.map((transaction) {
        return WithdrawalCard(
          amount: transaction['amount'],
          method: transaction['method'],
          provider: transaction['provider'],
          account: transaction['account'],
          id: transaction['id'],
          fee: transaction['fee'],
          date: transaction['date'],
          status: transaction['status'],
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: isDark ? Colors.grey[700] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No withdrawals found',
            style: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your ${selectedFilter.toLowerCase()} transactions will appear here',
            style: TextStyle(
              color: isDark ? Colors.grey[600] : Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
