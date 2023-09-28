import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Color color;
  final Function()? press;
  const CardWidget({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.press,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        //   border: Border.all(width: 0),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            spreadRadius: -15,
            color: Colors.grey,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white,
            onTap: press!,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: CustomStyle.cardBoxDecoration,
                    child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(svgSrc),
                        )),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    color: Colors.amber,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
