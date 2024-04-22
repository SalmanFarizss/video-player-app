import 'package:flutter/material.dart';

import '../features/auth/screens/splash_screen.dart';
ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade200,
      background: Colors.grey.shade100
    )
);
ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.light(
        primary: Colors.grey.shade700,
        secondary: Colors.grey.shade600,
        background: Colors.grey.shade500
    )
);
class Palette {
    // Colors
    static const scaffoldColor = Color.fromRGBO(243,243,243,1);
    static const whiteColor = Color.fromRGBO(255,255,255,1);
    static const primaryColor = Color.fromRGBO(87, 238, 157, 1);
    static var scaffoldDarkColor = Colors.grey.shade900;
    static var greyColor = Colors.grey.shade600;
    static var blackColor = Colors.black;
    // Themes
    static var darkModeAppTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: scaffoldDarkColor,
        cardColor: greyColor,
        iconTheme: const IconThemeData(
            color: whiteColor,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: scaffoldDarkColor,
            iconTheme: const IconThemeData(
                color: whiteColor,
            ),
        ),
        drawerTheme:  DrawerThemeData(
            backgroundColor: scaffoldDarkColor,
        ),
        primaryColor: primaryColor,
        backgroundColor: scaffoldDarkColor,
        textTheme: TextTheme(
            bodyLarge: TextStyle(color:whiteColor,fontSize: width * 0.08, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(color:whiteColor, fontSize: width * 0.045,),
            bodySmall: TextStyle(color: whiteColor,fontSize: width * 0.03,),
            labelLarge: TextStyle(color:whiteColor, fontSize: width * 0.05,fontWeight: FontWeight.w500),
            labelSmall: TextStyle(color:greyColor, fontSize: width * 0.035,),
        )// will be used as alternative background color
    );

    static var lightModeAppTheme = ThemeData.light().copyWith(
        scaffoldBackgroundColor: scaffoldColor,
        cardColor: whiteColor,
        iconTheme: IconThemeData(
            color: blackColor,
        ),
        appBarTheme:AppBarTheme(
            backgroundColor: scaffoldColor,
            elevation: 0,
            iconTheme: IconThemeData(
                color: blackColor,
            ),
        ),
        drawerTheme: const DrawerThemeData(
            backgroundColor: scaffoldColor,
        ),
        primaryColor: primaryColor,
        backgroundColor: scaffoldColor,
        textTheme: TextTheme(
            bodyLarge: TextStyle(color:blackColor,fontSize: width * 0.08, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(color:blackColor, fontSize: width * 0.045,),
            bodySmall: TextStyle(color: greyColor,fontSize: width * 0.03,),
            labelLarge: TextStyle(color:whiteColor, fontSize: width * 0.05,fontWeight: FontWeight.w500),
            labelSmall: TextStyle(color:greyColor, fontSize: width * 0.035,),
        )
    );
}