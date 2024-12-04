import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartpay/src/common/extensions/extensions.dart';

import '../constant/app_constants.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;
  final Color? backgroundColor;
  final Widget? child;

  const ShimmerContainer({
    super.key,
    this.width = double.infinity,
    this.height = 80,
    this.shape = BoxShape.rectangle,
    this.borderRadius = AppConstants.borderRadius,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.primary.withOpacity(0.3),
      highlightColor: context.colorScheme.primary.withOpacity(0.1),
      period: const Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
