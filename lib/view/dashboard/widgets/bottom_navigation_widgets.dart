import 'package:badges/badges.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_main_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            HomeScreen(),
            CartScreen(),
            ProfileMainPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: kButtonColor
        ),
        unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: kLightGreyColor
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        selectedIconTheme: const IconThemeData(
          color: kButtonColor
        ),
        unselectedIconTheme: const IconThemeData(
            color: kLightGreyColor
        ),
        items:  const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_alt_fill,size: 20,),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill,size: 20,),
              label: "Cart"
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_fill,size: 20,),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}

