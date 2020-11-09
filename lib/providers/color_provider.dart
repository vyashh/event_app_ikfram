import 'package:flutter/material.dart';
import '../utils/custom_color_scheme.dart';

class ColorProvider {
  static Color colorGetter({String eventColor, BuildContext ctx}) {
    ColorScheme theme = Theme.of(ctx).colorScheme;

    switch (eventColor) {
      case 'blue':
        return theme.blue;
        break;
      case 'mint':
        return theme.mint;
        break;
      case 'pink':
        return theme.pink;
        break;
      case 'purple':
        return theme.purple;
        break;
      default:
        return Colors.white;
    }
  }
}
