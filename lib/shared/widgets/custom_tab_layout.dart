import 'package:flutter/material.dart';

class CustomTabLayout extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;
  final int initialIndex;

  const CustomTabLayout({
    super.key,
    required this.tabTitles,
    required this.tabViews,
    this.initialIndex = 0,
  }) : assert(tabTitles.length == tabViews.length, 'Titles and views must have the same length');

  @override
  State<CustomTabLayout> createState() => _CustomTabLayoutState();
}

class _CustomTabLayoutState extends State<CustomTabLayout> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Tambahkan jarak di sisi kiri & kanan
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            // Memberikan padding pada indikator agar tidak menempel ke pinggir box tab
            indicatorPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            indicator: BoxDecoration(
              color: const Color.fromRGBO(252, 147, 3, 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            labelStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              height: 1.0, // Menjaga teks tetap di tengah secara vertikal
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
            // Splash effect mengikuti bentuk kapsul
            splashBorderRadius: BorderRadius.circular(25.0),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            tabs: widget.tabTitles.map((title) => Tab(
              height: 48, // Tinggi tetap untuk mencegah pergeseran
              child: Text(title),
            )).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
