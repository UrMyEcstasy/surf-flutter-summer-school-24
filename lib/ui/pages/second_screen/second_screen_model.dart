// second_screen_model.dart

import 'package:flutter/material.dart';

class SecondScreenModel {
  final int initialIndex;
  late int currentPage;
  late final PageController pageController;

  final List<String> workersCats = [
    "assets/barmen_cat.jpg",
    "assets/fitness_cat.jpg",
    "assets/farmer_cat.jpg",
    "assets/plumber_cat.jpg",
    "assets/killer_cat.jpg",
    "assets/football_cat.jpg",
    "assets/journalist_cat.jpg",
    "assets/mafia_cat.jpg",
    "assets/stuard_cat.jpg",
    "assets/tractor_cat.jpg",
    "assets/ballet_cat.jpg",
    "assets/builder_cat.jpg",
    "assets/scientist_cat.jpg",
    "assets/programmer_cat.jpg",
    "assets/fireman_cat.jpg",
    "assets/soilder_cat.jpg",
    "assets/shop_cat.jpg",
    "assets/enginneer_cat.jpg",
    "assets/painter_cat.jpg",
    "assets/office_cat.jpg",
    "assets/doctor_cat.jpg",
    "assets/sailor_cat.jpg",
    "assets/teacher_cat.jpg",
    "assets/cooker_cat.jpg",
    "assets/florist_cat.jpg",
    "assets/air_cat.jpg",
    "assets/courier_cat.jpg",
    "assets/jobless_cat.jpg",
    "assets/space_cat.jpg",
    "assets/security_cat.jpg",
  ];

  SecondScreenModel(this.initialIndex);

  void init() {
    currentPage = initialIndex;
    pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.8,
    );
    pageController.addListener(_onPageChanged);
  }

  void dispose() {
    pageController
      ..removeListener(_onPageChanged)
      ..dispose();
  }

  void _onPageChanged() {
    final prevPage = currentPage;
    currentPage = pageController.page?.round() ?? currentPage;
  }

  void onPageTap(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
