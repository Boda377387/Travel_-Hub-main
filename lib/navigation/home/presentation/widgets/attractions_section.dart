import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/maps/presentation/views/full_map_screen.dart';

class AttractionsSection extends StatelessWidget {
  const AttractionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nearby Attractions".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FullMapScreen(),
                  ),
                );
              },
              child: Text(
                "View Full Map".tr(),
                style: TextStyle(
                  color: kBackgroundColor,
                  decoration: TextDecoration.underline,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: kLightBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.center,
          child: Text(
            "🗺️ Eiffel Tower · Louvre · Notre Dame · Arc de Triomphe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
