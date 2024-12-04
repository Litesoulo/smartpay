import 'package:flutter/material.dart';

import '../constant/app_constants.dart';

class SplashStack extends StatelessWidget {
  const SplashStack({
    super.key,
    required this.child,
    this.onTap,
    this.height,
    this.width,
    this.radius,
  });

  final Widget child;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(radius ?? AppConstants.borderRadius),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
