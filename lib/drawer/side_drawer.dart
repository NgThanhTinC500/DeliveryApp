import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Halal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Halal@example.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Chip(
                    avatar: const Icon(Icons.star, color: Colors.orange, size: 16),
                    label: const Text('Premium'),
                    backgroundColor: Colors.orange.shade50,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('General', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            _buildDrawerItem(icon: Icons.person_outline, title: 'My Account'),
            _buildDrawerItem(icon: Icons.list_alt_outlined, title: 'My Orders'),
            _buildDrawerItem(icon: Icons.payment_outlined, title: 'Payment'),
            _buildDrawerItem(icon: Icons.location_on_outlined, title: 'Addresses'),
            _buildDrawerItem(icon: Icons.card_giftcard_outlined, title: 'Subscription'),
            _buildDrawerItem(icon: Icons.settings_outlined, title: 'Settings'),
            _buildDrawerItem(icon: Icons.store_outlined, title: 'My shop'),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Theme', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark mode'),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
                activeColor: Colors.green,
              ),
              onTap: () {
                 setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () {},
    );
  }
}
