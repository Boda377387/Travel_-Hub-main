import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 12.h),
        child: Text(
          "Discover amazing places around the world".tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kAssets,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
