import 'package:flutter/material.dart';
import '../widgets/notification_tile.dart';
import '../widgets/filter_chip_widget.dart';
import '../data/notification_data.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool notificationEnabled = true;
  String selectedFilter = 'All';

  final List<String> filters = [
    'All',
    'Price Alert',
    'Transaction',
    'Security',
    'Account',
    'Rewards',
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    final allNotifications = NotificationData.allNotifications;

    if (selectedFilter == 'All') {
      return allNotifications;
    }
    return allNotifications.where((notification) {
      return notification['tag'] == selectedFilter;
    }).toList();
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
            _buildNotificationSettings(theme, isDark),
            _buildFilterChips(),
            _buildNotificationsList(),
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
        'Notifications',
        style: theme.appBarTheme.titleTextStyle,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: theme.appBarTheme.iconTheme?.color,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildNotificationSettings(ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.settings,
            color: theme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            'Notification Settings',
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Switch(
            value: notificationEnabled,
            onChanged: (value) {
              setState(() {
                notificationEnabled = value;
              });
            },
            activeColor: theme.primaryColor,
            activeTrackColor: theme.primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChipWidget(
              label: filters[index],
              isSelected: selectedFilter == filters[index],
              onTap: () {
                setState(() {
                  selectedFilter = filters[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: filteredNotifications.map((notification) {
        return NotificationTile(
          icon: notification['icon'],
          iconColor: notification['iconColor'],
          iconBackground: notification['iconBackground'],
          title: notification['title'],
          subtitle: notification['subtitle'],
          time: notification['time'],
          tag: notification['tag'],
          tagColor: notification['tagColor'],
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
            Icons.notifications_off_outlined,
            size: 64,
            color: isDark ? Colors.grey[700] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications found',
            style: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for updates',
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