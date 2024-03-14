
import 'package:djiguiba_music/consts/colors.dart';
import 'package:flutter/material.dart';

const bold = 'bold';
const regular = 'regular';

 monTextStyle({family = 'regular',double? size = 14, color = whiteColor}){
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: family
  );
}