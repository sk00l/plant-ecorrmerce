import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/themes/bloc/theme_bloc.dart';
import 'package:plant_ecommerce/themes/configs/baseappcolor.dart';

/// This extension adds a convenient way to access the current theme and
/// app color from any context.
///
/// It uses the [BlocBuilder] to build the [ThemeBloc] and access the current
/// state, which is either a [ThemeChanged] or the default [InitialTheme].
///
/// If the state is a [ThemeChanged], it returns the app color depending on
/// the brightness of the current theme. If the state is the default
/// [InitialTheme], it returns the LightAppColor.
///
/// The app color is used to access the color values like [BaseAppColor.primary]
/// or [BaseAppColor.secondary].
extension BuildContextExtension on BuildContext {
  /// Returns the current theme of this context.
  TextTheme get theme => Theme.of(this).textTheme;

  /// Returns the current app color depending on the brightness of the
  /// current theme.
  BaseAppColor get appColor => watch<ThemeBloc>().state is ThemeChanged
      ? (watch<ThemeBloc>().state as ThemeChanged).themeData.brightness ==
              Brightness.dark
          ? DarkAppColor()
          : LightAppColor()
      : LightAppColor();
}
