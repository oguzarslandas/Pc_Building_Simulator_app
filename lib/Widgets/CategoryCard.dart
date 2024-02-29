import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? svgSrc;
  final String title;
  final Color color;
  final Function()? press;
  const CategoryCard({
    Key? key,
    this.svgSrc,
    required this.title,
    required this.press,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Stack(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: press!,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * .12,
                width: double.infinity,
                decoration: CustomStyle.cardBoxDecoration,
                child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: CustomStyle.dashboardTextStyle
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 110,
                  height: 110,
                  child: Image.asset(svgSrc!)),
            ),
          ]
        ),

      ],
    );
  }
}
