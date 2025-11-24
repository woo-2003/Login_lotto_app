import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LottoBall extends StatelessWidget {
  const LottoBall({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SvgPicture.asset(
        path,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
    );
  }
}

