import 'package:flutter/material.dart';
import 'package:x_rate_app/core/utils/global_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String image;
  const CustomAppBar({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        image,
        height: heightValue45,
        // width: heightValue26,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(heightValue50);
  }
}
