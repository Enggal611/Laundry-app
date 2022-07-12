import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../admin/profile.dart';
import '../form/formOrder/readOrder.dart';
import 'pending.dart';
import 'userPage.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _button = 0;

  final List<Widget> _item = [
    userPage(),
    pending(),
    readOrder(),
    account(
      id: '',
      nama: '',
      alamat: '',
      telepon: '',
      email: '',
      password: '',
    )
  ];

  void _onItemTap(int index) {
    setState(() {
      _button = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _item.elementAt(_button),
        ),
        bottomNavigationBar: Container(
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GNav(
                backgroundColor: Colors.blueAccent,
                color: Colors.white,
                activeColor: Color.fromARGB(255, 0, 41, 112),
                tabBackgroundColor: Colors.blue.shade300,
                gap: 8,
                onTabChange: _onItemTap,
                padding: EdgeInsets.all(15),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.pending_actions_sharp,
                    text: 'On Process',
                  ),
                  GButton(
                    icon: Icons.history,
                    text: 'History',
                  ),
                  GButton(
                    icon: Icons.account_circle_outlined,
                    text: 'Account',
                  ),
                ]),
          ),
        ));
  }
}
