import 'package:flutter/material.dart';
import '../screens/notifications_screen.dart';
import '../widgets/withdrawal_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/filter_chip_widget.dart';
import '../data/withdrawal_data.dart';

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


// ============================================
// FILE: data/withdrawal_data.dart
// ============================================
class WithdrawalData {
  static final List<Map<String, dynamic>> allTransactions = [
    {
      'amount': 500.00,
      'method': 'Bank Transfer',
      'provider': 'Jank Tran',
      'account': '****1234',
      'id': 'WD784512',
      'fee': 1.50,
      'date': '15/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 200.00,
      'method': 'Mobile Money',
      'provider': 'MTN Mobile',
      'account': '****5678',
      'id': 'WD784511',
      'fee': 1.00,
      'date': '14/1/2024',
      'status': 'Processing',
    },
    {
      'amount': 1000.00,
      'method': 'Bank Transfer',
      'provider': 'Jank Tran',
      'account': '****1234',
      'id': 'WD784510',
      'fee': 2.50,
      'date': '12/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 150.00,
      'method': 'Mobile Money',
      'provider': 'Airtel Money',
      'account': '****9012',
      'id': 'WD784509',
      'fee': 1.00,
      'date': '10/1/2024',
      'status': 'Failed',
    },
    {
      'amount': 750.00,
      'method': 'Bank Transfer',
      'provider': 'Jank Tran',
      'account': '****1234',
      'id': 'WD784508',
      'fee': 2.00,
      'date': '8/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 300.00,
      'method': 'UPI',
      'provider': 'Google Pay',
      'account': '****4567',
      'id': 'WD784507',
      'fee': 0.50,
      'date': '6/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 450.00,
      'method': 'Bank Transfer',
      'provider': 'HDFC Bank',
      'account': '****8901',
      'id': 'WD784506',
      'fee': 1.50,
      'date': '5/1/2024',
      'status': 'Processing',
    },
    {
      'amount': 850.00,
      'method': 'Mobile Money',
      'provider': 'Paytm Wallet',
      'account': '****2345',
      'id': 'WD784505',
      'fee': 2.00,
      'date': '3/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 100.00,
      'method': 'UPI',
      'provider': 'PhonePe',
      'account': '****6789',
      'id': 'WD784504',
      'fee': 0.50,
      'date': '2/1/2024',
      'status': 'Failed',
    },
    {
      'amount': 1200.00,
      'method': 'Bank Transfer',
      'provider': 'ICICI Bank',
      'account': '****3456',
      'id': 'WD784503',
      'fee': 3.00,
      'date': '1/1/2024',
      'status': 'Completed',
    },
    {
      'amount': 600.00,
      'method': 'Mobile Money',
      'provider': 'MTN Mobile',
      'account': '****5678',
      'id': 'WD784502',
      'fee': 1.50,
      'date': '30/12/2023',
      'status': 'Processing',
    },
    {
      'amount': 250.00,
      'method': 'UPI',
      'provider': 'Google Pay',
      'account': '****7890',
      'id': 'WD784501',
      'fee': 0.50,
      'date': '28/12/2023',
      'status': 'Completed',
    },
    {
      'amount': 900.00,
      'method': 'Bank Transfer',
      'provider': 'Jank Tran',
      'account': '****1234',
      'id': 'WD784500',
      'fee': 2.50,
      'date': '26/12/2023',
      'status': 'Completed',
    },
    {
      'amount': 175.00,
      'method': 'Mobile Money',
      'provider': 'Airtel Money',
      'account': '****9012',
      'id': 'WD784499',
      'fee': 1.00,
      'date': '24/12/2023',
      'status': 'Failed',
    },
    {
      'amount': 550.00,
      'method': 'UPI',
      'provider': 'PhonePe',
      'account': '****4567',
      'id': 'WD784498',
      'fee': 1.00,
      'date': '22/12/2023',
      'status': 'Completed',
    },
    {
      'amount': 400.00,
      'method': 'Bank Transfer',
      'provider': 'HDFC Bank',
      'account': '****8901',
      'id': 'WD784497',
      'fee': 1.50,
      'date': '20/12/2023',
      'status': 'Processing',
    },
    {
      'amount': 1500.00,
      'method': 'Bank Transfer',
      'provider': 'SBI Bank',
      'account': '****2468',
      'id': 'WD784496',
      'fee': 3.50,
      'date': '18/12/2023',
      'status': 'Completed',
    },
    {
      'amount': 325.00,
      'method': 'Mobile Money',
      'provider': 'Paytm Wallet',
      'account': '****1357',
      'id': 'WD784495',
      'fee': 1.00,
      'date': '16/12/2023',
      'status': 'Completed',
    },
    {
      'amount': 700.00,
      'method': 'UPI',
      'provider': 'Google Pay',
      'account': '****9876',
      'id': 'WD784494',
      'fee': 1.50,
      'date': '14/12/2023',
      'status': 'Failed',
    },
    {
      'amount': 950.00,
      'method': 'Bank Transfer',
      'provider': 'ICICI Bank',
      'account': '****3456',
      'id': 'WD784493',
      'fee': 2.50,
      'date': '12/12/2023',
      'status': 'Completed',
    },
  ];
}