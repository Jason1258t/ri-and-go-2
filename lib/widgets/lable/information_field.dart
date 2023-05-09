import 'package:flutter/material.dart';
import 'package:riandgo2/utils/fonts.dart';

class InfoField extends StatelessWidget {
  String name;
  String value;

  InfoField({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTypography.font20grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Color(0xff4D361C),
                      width: 1,
                    ))),
            child: Text(
              value,
              style: AppTypography.font12,
            ),
          ),
        ],
      ),
    );
  }
}
