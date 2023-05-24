import 'package:flutter/material.dart';
import 'package:riandgo2/utils/fonts.dart';

class FirstSlide extends StatefulWidget {
  FirstSlide({
    Key? key,
  }) : super(key: key);

  @override
  _FirstSlideState createState() => _FirstSlideState();
}

class _FirstSlideState extends State<FirstSlide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/Group.png"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Привет! ' +
                    'Мы рады представить наше новое мобильное приложение, которое поможет тебе сэкономить деньги и познакомиться с новыми людьми во время поездок и путешествий. ' +
                    'Наше приложение основано на идее совместного использования автомобилей, чтобы снизить расходы на топливо и аренду автомобилей.',
                style: AppTypography.font20black87,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
