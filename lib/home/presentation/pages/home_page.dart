import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/widgets/custom_scaffold/momento_las_scaffold.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/pages/blog_tab.dart';
import 'package:momento_las_palmas/tabs/favourite_places/favourite_places_tab.dart';
import 'package:momento_las_palmas/tabs/map/presentation/pages/map_tab.dart';
import 'package:momento_las_palmas/tabs/spin_tab/presentation/pages/spin_tab.dart';
import 'package:momento_las_palmas/tabs/time_picker/presentation/pages/time_picker_tab.dart';

final GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>();

class HomePage extends StatefulWidget {
  HomePage() : super(key: homePageKey);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _showSplash = true;
  int _selectedIndex = 3;
  String? _mapCoordinates;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void backToTimePickerTab() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  void backToMap({String? coordinates}) {
    setState(() {
      _selectedIndex = 4;
      _mapCoordinates = coordinates;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return Scaffold(
        body: SizedBox.expand(
          child: Image.asset(
            'assets/images/l2.png',
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = const BlogTab();
        break;
      case 1:
        body = const FavouritesPlacesTab();
        break;
      case 2:
        body = const SpinTab();
        break;
      case 3:
        body = const TimePickerTab();
        break;
      case 4:
        body = MapTab(initialCoordinates: _mapCoordinates ?? '');
        break;
      default:
        body = const Center(child: Text('Unknown tab'));
    }

    return MomentoLasScaffold(
      gradientBackground: false,
      body: body,
      selectedIndex: _selectedIndex,
      onTabSelected: _onTabSelected,
    );
  }
}