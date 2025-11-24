import 'package:flutter/material.dart';
import 'package:login_app/lotto.dart';

class Breakpoint {
  static const double mobile = 600;
  static const double tablet = 1200;
}

class LayoutLotto extends StatelessWidget {
  const LayoutLotto({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < Breakpoint.mobile) {
      // 모바일
      return Lotto();
    } else if (width < Breakpoint.tablet) {
      // 태블릿
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Breakpoint.tablet),
          child: Lotto(),
        ),
      );
    } else {
      // 데스크탑
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Breakpoint.tablet),
          child: Lotto(),
        ),
      );
    }
  }
}

