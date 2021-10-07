import 'package:flutter/material.dart';
import 'package:worm_page_indicator/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<Color> _colorList = [
    Colors.teal,
    Colors.yellow,
    Colors.blue,
    Colors.deepOrange,
    Colors.black,
    Colors.cyan,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 400,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    height: 400,
                    color: _colorList[index],
                  ),
                );
              },
              itemCount: _colorList.length,
            ),
          ),
          if (_colorList.length != 1) ...[
            AnimatedBuilder(
              animation: _pageController,
              builder: (context, snapshot) {
                return CustomPaint(
                  painter: WarmPageIndicatorPainter(
                    pageCount: _colorList.length,
                    dotRadius: 7,
                    dotOutlineThickness: 1,
                    spaceNumberBetweenDots: 5,
                    dotFillColor: Colors.transparent,
                    dotOutlineColor: Colors.purple,
                    indicatorColor: Colors.purple,
                    scrollPosition:
                        _pageController.hasClients && _pageController.page != null ? _pageController.page! : 0.0,
                  ),
                );
              },
            ),
          ]

          //
        ],
      ),
    );
  }
}
