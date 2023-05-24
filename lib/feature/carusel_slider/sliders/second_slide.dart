import 'package:flutter/material.dart';
import 'package:riandgo2/utils/fonts.dart';

class SecondSlide extends StatefulWidget {
  SecondSlide({
    Key? key,
  }) : super(key: key);

  @override
  _SecondSlideState createState() => _SecondSlideState();
}

class _SecondSlideState extends State<SecondSlide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/Word.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'С помощью' +
                    'нашего приложения ты можешь легко найти попутчиков, которые отправляются в ту же сторону, что и ты, или найти интересных людей,' +
                    'которые готовы поделиться своим автомобилем для совместной поездки. Наше приложение обеспечивает удобный способ поиска ' +
                    'попутчиков, а также обеспечивает безопасность и комфорт во время поездки.',
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
