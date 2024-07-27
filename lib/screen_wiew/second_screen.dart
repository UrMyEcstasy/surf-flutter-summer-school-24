import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<String> workersCats = [

  ];

class SecondScreen extends StatefulWidget {
  final int initialIndex;

  const SecondScreen({super.key, required this.initialIndex});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  static const _defaultAnimDuration = Duration(milliseconds: 300);

  late int currentPage;
  late final PageController _pageController;

  @override
  void initState() {
    currentPage = widget.initialIndex;
    _pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.8,
    );
    _pageController.addListener(_onPageChanged);
    super.initState();
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final prevPage = currentPage;
    currentPage = _pageController.page?.round() ?? currentPage;
    if (prevPage != currentPage) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(currentDate),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${currentPage + 1}/${workersCats.length}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: workersCats.length,
        itemBuilder: (_, i) => Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            scale: currentPage == i ? 1 : 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => _pageController.animateToPage(
                  i,
                  duration: _defaultAnimDuration,
                  curve: Curves.easeIn,
                ),
                child: _PageViewItem(image: workersCats[i]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageViewItem extends StatelessWidget {
  final String image;

  const _PageViewItem({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 600,
        width: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}