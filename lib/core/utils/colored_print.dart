import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';

AnsiPen info = AnsiPen()..blue(bold: true);
AnsiPen success = AnsiPen()..green(bold: true);
AnsiPen warning = AnsiPen()..yellow(bold: true);
AnsiPen error = AnsiPen()..red(bold: true);
//  bool ansiColorDisabled = false;
void coloredPrint({required String message}) {
  ansiColorDisabled = false;
  debugPrint(success(message));
}
