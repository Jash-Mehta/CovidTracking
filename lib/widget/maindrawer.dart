import 'package:covid_tracking/screen/tracking_covid.dart';
import 'package:covid_tracking/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        style: DrawerStyle.Style3,
        menuScreen: MenuPage(),
        mainScreen: TrackingCovid());
  }
}
