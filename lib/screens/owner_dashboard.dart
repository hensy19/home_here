// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'visit_requests_page.dart';
import 'properties_page.dart';
import 'owner_profile_page.dart';

class OwnerDashboard extends StatefulWidget {
  static const routeName = '/owner_dashboard';

  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardHomePage(),
    PropertiesPage(),
    VisitRequestsPage(),
    OwnerProfilePage(),
  ];

  // Handle back button
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      // If not on dashboard tab, go back to dashboard
      setState(() {
        _currentIndex = 0;
      });
      return false; // Prevent default back
    } else {
      // Optional: show dialog to exit app instead of logging out
      final exit = await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Exit')),
          ],
        ),
      );
      return exit ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _currentIndex == 0
            ? AppBar(
                title: Text('Owner Dashboard'),
                centerTitle: true,
              )
            : null,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Properties'),
            BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Requests'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// Dashboard content (same as before)
class DashboardHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _OwnerDashboardState? parentState =
        context.findAncestorStateOfType<_OwnerDashboardState>();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    parentState?._currentIndex = 1;
                    parentState?.setState(() {});
                  },
                  child: Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.home, size: 36, color: Colors.blue),
                          SizedBox(height: 8),
                          Text('Properties',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('2',
                              style: TextStyle(fontSize: 20, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    parentState?._currentIndex = 2;
                    parentState?.setState(() {});
                  },
                  child: Card(
                    color: Colors.green[50],
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.person_add_alt_1,
                              size: 36, color: Colors.green),
                          SizedBox(height: 8),
                          Text('Visit Requests',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('1',
                              style: TextStyle(fontSize: 20, color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Requests',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  parentState?._currentIndex = 2;
                  parentState?.setState(() {});
                },
                child: Text('View All'),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Text('M')),
                  title: Text('Mina Sharma'),
                  subtitle: Text('Shivangi Girls Hostel\nDate: 08/07/2025'),
                  trailing: Chip(
                      label: Text('Declined'),
                      backgroundColor: Colors.red[50]),
                ),
                ListTile(
                  leading: CircleAvatar(child: Text('F')),
                  title: Text('Fairy Patel'),
                  subtitle: Text('Shivangi Girls Hostel\nDate: 08/07/2025'),
                  trailing: Chip(
                      label: Text('Pending'),
                      backgroundColor: Colors.orange[50]),
                ),
                ListTile(
                  leading: CircleAvatar(child: Text('T')),
                  title: Text('Tej Patel'),
                  subtitle: Text('Vistara PG \nDate: 08/07/2025'),
                  trailing: Chip(
                      label: Text('Pending'),
                      backgroundColor: Colors.orange[50]),
                ),
                ListTile(
                  leading: CircleAvatar(child: Text('P')),
                  title: Text('Piya Tandel'),
                  subtitle: Text('Celestia Living Girls Hostel\nDate: 08/17/2025'),
                  trailing: Chip(
                      label: Text('Accepted'),
                      backgroundColor: Colors.green[50]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
