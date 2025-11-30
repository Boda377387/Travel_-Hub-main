import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/land_mark/data/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'package:travel_hub/navigation/land_mark/models/land_mark_model.dart';


class LandMarkDetailsScreen extends StatelessWidget {
  final LandMark landMark;
  LandMarkDetailsScreen(this.landMark, {super.key});
  final CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    final List<String> images = [landMark.mainImage, ...landMark.galleryImages];

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 85.w),
            Text(
              "Place Details".tr(),
              style: TextStyle(color: kBlack, fontSize: 16.sp),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            BlocBuilder<CarouselSliderCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        height: 200.h,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        onPageChanged: (index, reason) {
                          context.read<CarouselSliderCubit>().changePage(index);
                        },
                      ),
                      items: images.map((imagePath) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.r),
                            child: CachedNetworkImage( fit: BoxFit.cover, imageUrl: imagePath,
                            placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            controller.animateToPage(entry.key);
                          },
                          child: Container(
                            width: state == entry.key ? 12.h : 8.h,
                            height: 10.h,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: state == entry.key
                                  ? kBackgroundColor
                                  : kGrey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    landMark.name,
                    style: TextStyle(color: kBlack, fontSize: 16.sp),
                  ),
                  Text(
                    landMark.location,
                    style: TextStyle(color: kAssets, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About".tr(),
                      style: TextStyle(color: kBlack, fontSize: 18.sp),
                    ),
                    Text(
                      landMark.detailedInfo,
                      style: TextStyle(color: kAssets, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
