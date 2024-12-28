import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';
import 'package:myapp/views/moment/pages/moment_page.dart';
import 'package:myapp/views/moment/pages/moment_search_page.dart';
import 'package:myapp/core/resources/colors.dart';

import '../../user/pages/user_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variabel untuk menyimpan index halaman yang aktif
  int _seletedPageIndex = 0;

  // Fungsi untuk mengubah index halaman yang aktif
  void _onPageChanged(int index) {
    if (index == 2) {
      // Jika index halaman adalah 2, maka navigasi ke halaman create moment
      context.read<MomentBloc>().add(MomentNavigateToAddEvent());
    } else {
      // Jika index halaman bukan 2, maka navigasi ke halaman yang sesuai
      setState(() {
        _seletedPageIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<MomentBloc>().add(MomentGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    // List halaman yang tersedia
    final List<Widget> pages = [
      const MomentPage(),
      const MomentSearchPage(),
      const Center(
        child: Text('Create Moment'),
      ),
      const Center(
        child: Text('Activity'),
      ),
      const UserPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/moments_text.png',
          height: 32,
        ),
        centerTitle: true,
      ),
      body: pages[_seletedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-home.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-home.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-search.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-search.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-add.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-add.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-heart.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-heart.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-portrait.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-portrait.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        onTap: _onPageChanged,
        currentIndex: _seletedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
