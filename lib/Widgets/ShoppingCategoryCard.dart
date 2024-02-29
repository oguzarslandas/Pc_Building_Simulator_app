import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:flutter/material.dart';
import 'package:pc_building_simulator/Utils/images.dart';

class ShoppingCategoryCard extends StatelessWidget {
  final List svgSrc;
  final String title;
  final String location;
  final String detail;
  final int price;
  final Color color;
  final Function()? press;
  const ShoppingCategoryCard({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.location,
    required this.price,
    required this.press,
    required this.detail,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press!,
      splashColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .24,
            padding: EdgeInsets.all(8),

            //       width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.secondaryColor1.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(15),),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                      height: size.height * 0.10,
                      width: size.width * 0.20,
                      child: Image.network(
                        svgSrc[0].toString(),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                Text(
                    price.toString() + 'currency'.tr,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: CustomStyle.headlineTextStyle
                ),
                Text(
                    title,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: CustomStyle.titleTextStyle
                ),
                Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                      '📍' + location,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: CustomStyle.slocationTextStyle
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
                onPressed: (){

                },
                icon: Icon(Boxicons.bx_like)
            ),
          ),
        ],
      ),
    );
  }
}
