import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart' as material;

class CardWidget extends StatelessWidget {
  CardWidget({
    required this.button,
    this.color,
    this.width,
    this.height,
    required this.child,
    this.duration,
    this.func,
    this.border,
  });
  final bool button;
  final Color? color;
  final double? width;
  final double? height;
  final Widget child;
  final int? duration;
  final Border? border;
  final func;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const material.BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            offset: Offset(0, 10),
            color: Color(0x1A636363),
          ),
        ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: material.AnimatedContainer(
          duration: Duration(milliseconds: duration ?? 500),
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: border ??
                Border.all(
                  color: material.Colors.white,
                  width: 0,
                ),
            // borderRadius: BorderRadius.circular(10),
            color: color ?? primaryColor,

          ),
          child: button
              ? ClipRRect(
            borderRadius: material.BorderRadius.circular(10),
            child: material.MaterialButton(
              padding: material.EdgeInsets.zero,
              elevation: 3,
              child: child,
              onPressed: func,
            ),
          )
              : child,
        ),
      ),
    );
  }
}