import 'package:flutter/material.dart';

// This uses the MaterialBasedCupertinoThemeData mechs so that
// we have one base text theme for both Material and Cupertino widgets
TextTheme myBaseTextTheme = TextTheme(
  displaySmall: myHeadline3,
  headlineSmall: myHeadline5,
  titleLarge: myHeadline6,
  titleMedium: mySubtitle1,
  titleSmall: mySubtitle2,
  bodySmall: myCaption,
);

TextStyle myHeadline3 = const TextStyle(
  inherit: true,
  fontSize: 48,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.0,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline3',
);

TextStyle myHeadline5 = const TextStyle(
  inherit: true,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  debugLabel: 'Headline5',
);

TextStyle myHeadline6 = const TextStyle(
  inherit: true,
  fontSize: 18,
  debugLabel: 'Headline6',
);

TextStyle mySubtitle1 = const TextStyle(
  inherit: true,
  fontSize: 16,
  debugLabel: 'Subtitle1',
);

TextStyle mySubtitle2 = const TextStyle(
  inherit: true,
  fontSize: 14,
  debugLabel: 'Subtitle2',
);

TextStyle myCaption = const TextStyle(
  inherit: true,
  fontSize: 12,
  fontWeight: FontWeight.w400,
  debugLabel: 'Caption',
);
