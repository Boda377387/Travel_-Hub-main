import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/home/home_screen.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_cubit.dart';
import 'package:travel_hub/navigation/land_mark/land_mark_screen.dart';
import 'package:travel_hub/navigation/maps/presentation/views/full_map_screen.dart';
import 'package:travel_hub/navigation/setting/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  late final List<Widget> _pages;

 @override
void initState() {
  super.initState();
  _pages = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => HotelsCubit()..loadHotels(),
      child: const HotelsScreen(),
    ),
     BlocProvider(
      create: (context) => LandMarkCubit()..loadLandMark(),
      child: const LandMarkScreen(),
    ),
    const FullMapScreen(),
    SettingScreen(
      isDarkMode: _isDarkMode,
      onToggleTheme: _toggleTheme,
    ),
  ];
}

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(child: _pages[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: kBackgroundColor,
          unselectedItemColor: kGrey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: isWide ? 14 : 12,
          unselectedFontSize: isWide ? 12 : 10,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.hotel), label: "Hotels".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.place), label: "Places".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings".tr()),
          ],
        ),
      ),
    );
  }
}
