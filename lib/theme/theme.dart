import 'package:flutter/material.dart';

import 'color.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme({
    required this.grey,
    required this.linen,
    required this.electric,
    required this.graphite,
    required this.slate,
    required this.seashell,
    required this.red,
    required this.green,
    required this.greyish,
  });

  final Color grey;

  final Color linen;

  final Color electric;

  final Color graphite;

  final Color slate;

  final Color seashell;

  final Color red;

  final Color green;

  final Color greyish;

  @override
  CustomTheme copyWith({
    Color? grey,
    Color? linen,
    Color? electric,
    Color? graphite,
    Color? slate,
    Color? seashell,
    Color? red,
    Color? green,
    Color? greyish,
  }) {
    return CustomTheme(
      grey: grey ?? this.grey,
      linen: linen ?? this.linen,
      electric: electric ?? this.electric,
      graphite: graphite ?? this.graphite,
      slate: slate ?? this.slate,
      seashell: seashell ?? this.seashell,
      red: red ?? this.red,
      green: green ?? this.green,
      greyish: greyish ?? this.greyish,
    );
  }

//list of themes
  static const CustomTheme dark = CustomTheme(
    grey: DarkColor.grey,
    linen: DarkColor.linen,
    electric: DarkColor.electric,
    graphite: DarkColor.graphite,
    slate: DarkColor.slate,
    seashell: DarkColor.seashell,
    red: DarkColor.red,
    green: DarkColor.green,
    greyish: DarkColor.greyish,
  );

  static const CustomTheme light = CustomTheme(
    grey: LightColor.grey,
    linen: LightColor.linen,
    electric: LightColor.electric,
    graphite: LightColor.graphite,
    slate: LightColor.slate,
    seashell: LightColor.seashell,
    red: LightColor.red,
    green: LightColor.green,
    greyish: LightColor.greyish,
  );

  @override
  ThemeExtension<CustomTheme> lerp(
    covariant ThemeExtension<CustomTheme>? other,
    double t,
  ) {
// TODO: implement lerp
    throw UnimplementedError();
  }
}
