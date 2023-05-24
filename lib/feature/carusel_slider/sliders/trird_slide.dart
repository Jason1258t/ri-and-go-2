import 'package:flutter/material.dart';
import 'package:riandgo2/feature/app/ui/main_screen.dart';
import 'package:riandgo2/utils/fonts.dart';

class ThirdSlide extends StatefulWidget {
  ThirdSlide({
    Key? key,
  }) : super(key: key);

  @override
  _ThirdSlideState createState() => _ThirdSlideState();
}

class _ThirdSlideState extends State<ThirdSlide> {

  void nextMainScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

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
                'Не трать время на долгие поиски попутчиков и путешественников,' +
                    'присоединяйся к нашему сообществу и наслаждайся приятной поездкой в компании интересных людей!',
                style: AppTypography.font20black87,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            TextButton(
              onPressed: nextMainScreen,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xffE6A050)),
                fixedSize: MaterialStateProperty.all(const Size(318, 45)),
              ),

              child: Text(
                'Продолжить',
                style: AppTypography.font20w400white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
