import 'package:flutter/material.dart';
import '../model/match.dart' as match_lib;
import '../model/team.dart';

class TextTeamsPainter extends CustomPainter {
  TextTeamsPainter({required this.pisteSize, required this.match});

  Size pisteSize;
  match_lib.Match match;

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter residentPainter = _textPainterForTeam(match.resident);
    final TextPainter visiteurPainter = _textPainterForTeam(match.visiteur);

    final Offset residentOffset = getResidentOffset(residentPainter);
    final Offset visiteurOffset = getVisiteurOffset(visiteurPainter);

    residentPainter.paint(canvas, residentOffset);
    visiteurPainter.paint(canvas, visiteurOffset);
  }

  TextPainter _textPainterForTeam(Team team) {
    const textStyle = TextStyle(
        color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);
    TextSpan textSpan = TextSpan(text: team.nomCourt, style: textStyle);
    TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(
      minWidth: 0,
      maxWidth: pisteSize!.width,
    );
    return textPainter;
  }

  Offset getResidentOffset(TextPainter textPainter) {
    final x = (pisteSize.width - textPainter.width) / 2;
    const y = 0;
    return Offset(x as double, y as double);
  }

  Offset getVisiteurOffset(TextPainter textPainter) {
    final x = (pisteSize.width - textPainter.width) / 2;
    final y = pisteSize.height - textPainter.height;
    return Offset(x as double, y as double);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
