import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // نحتاج لاستيراد ImagePicker
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/custom_app_bar.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/navigation/home/presentation/widgets/action_button.dart';
import 'package:travel_hub/navigation/home/presentation/widgets/attractions_section.dart';
import 'package:travel_hub/navigation/home/presentation/widgets/home_header.dart';
import 'package:travel_hub/navigation/home/presentation/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleCameraTap(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Camera'.tr()),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text('Gallery'.tr()),
                onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source, imageQuality: 80);

      if (pickedFile != null) {
        final selectedImage = File(pickedFile.path);

 
        GoRouter.of(context).push(
          AppRouter.kCameraView,
          extra: selectedImage,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 8),
      child: Scaffold(
        appBar: CustomAppBar(
          title: " Welcome to Travel Hub".tr(),
          centerTitle: true,
          bottomWidget: const HomeHeader(),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchField(),
              SizedBox(height: 20.h),

              LayoutBuilder(
                builder: (context, constraints) {
                  final buttonWidth = (constraints.maxWidth - 16.w) / 2;
                  return Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children: [
                      ActionButton(
                        color: kBackgroundColor,
                        icon: Icons.hotel,
                        label: "Hotels".tr(),
                        onTap: () => GoRouter.of(context)
                            .push(AppRouter.kHotelsView),
                        width: buttonWidth,
                      ),
                      ActionButton(
                        color: kOrange,
                        icon: Icons.place,
                        label: "Places to Visit".tr(),
                        onTap: () => GoRouter.of(context)
                            .push(AppRouter.kLandMarkView),
                        width: buttonWidth,
                      ),
                      ActionButton(
                        color: kGreen,
                        icon: Icons.map,
                        label: "Map".tr(),
                        onTap: () => GoRouter.of(context)
                            .push(AppRouter.kMapView),
                        width: buttonWidth,
                      ),
                      ActionButton(
                        color: kPurple,
                        icon: Icons.camera_alt,
                        label: "AI Camera".tr(),
                        onTap: () => _handleCameraTap(context), 
                        width: buttonWidth,
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 24.h),
              const AttractionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}