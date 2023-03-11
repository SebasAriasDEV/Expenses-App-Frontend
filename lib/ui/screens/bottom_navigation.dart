import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/ui/components/transactions/add_transaction_modal.dart';
import 'package:i_budget_app/ui/screens/home_screen.dart';
import 'package:i_budget_app/utils/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final iconList = [Icons.arrow_upward, Icons.arrow_downward];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const ModalCreateTransaction(),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => activeIndex = index),
        //other params
      ),
      body: const HomeScreen(),
    );
  }
}
