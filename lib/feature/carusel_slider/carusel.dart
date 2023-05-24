import 'package:flutter/material.dart';
import 'package:riandgo2/feature/carusel_slider/sliders/second_slide.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Sliders/trird_slide.dart';
import 'Sliders/first_slide.dart';

class MainCarousel extends StatefulWidget {
  MainCarousel({
    Key? key,
  }) : super(key: key);

  @override
  _ainCarouselState createState() => _ainCarouselState();
}

class _ainCarouselState extends State<MainCarousel> {
  static List<Widget> elements = <Widget>[
    FirstSlide(),
    SecondSlide(),
    ThirdSlide(),
  ];
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemCount: elements.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: elements[index],
                          ),
                        );
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < elements.length; i++)...[
                  buildIndicator(currentIndex == i),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      height: isSelected ? 12 : 8,
      width: isSelected ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.black : Colors.orangeAccent,
      ),
    );
  }
}
