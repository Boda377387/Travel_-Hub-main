import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/hotels/presentation/widgets/custom_button.dart';
import 'package:travel_hub/navigation/hotels/presentation/widgets/custom_field.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController destination = TextEditingController();
  final TextEditingController checkIn = TextEditingController();
  final TextEditingController checkOut = TextEditingController();
  final TextEditingController guests = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      String formDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        controller.text = formDate;
      });
    }
  }

  late DateTime selectedDate;
  late DateTime today;
  late DateTime todayDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    todayDate = DateTime(today.year, today.month, today.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Book Your Trip".tr(),
              style: TextStyle(color: Colors.white, fontSize: 24.sp),
            ),
            Text(
              "Complete your reservation".tr(),
              style: TextStyle(color: Color(0xffDBEAFE), fontSize: 16.sp),
            ),
          ],
        ),
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomField(
                title: "Destination".tr(),
                width: double.infinity,
                controller: destination,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter city or hotel name".tr();
                  }
                  return null;
                },
                hint: "Enter city or hotel name".tr(),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomField(
                      title: "Check-in".tr(),
                      width: double.infinity,
                      controller: checkIn,
                      keyboard: TextInputType.datetime,
                      onTap: () {
                        return selectDate(context, checkIn);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a check in date".tr();
                        }
                        try {
                          selectedDate = DateFormat(
                            'dd/MM/yyyy',
                          ).parseStrict(value);
                          if (selectedDate.isBefore(todayDate)) {
                            return "Check in date can't be before today".tr();
                          }
                        } catch (e) {
                          return "The date format is incorrect".tr();
                        }
                        return null;
                      },
                      icon: Icons.calendar_today,
                      hint: "DD/MM/YYYY",
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      title: "Check-out".tr(),
                      width: double.infinity,
                      controller: checkOut,
                      keyboard: TextInputType.datetime,
                      onTap: () {
                        return selectDate(context, checkOut);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a check out date".tr();
                        }
                        try {
                          selectedDate = DateFormat(
                            'dd/MM/yyyy',
                          ).parseStrict(value);
                          if (selectedDate.isBefore(todayDate)) {
                            return "Check out date can't be before today".tr();
                          }
                        } catch (e) {
                          return "The date format is incorrect".tr();
                        }
                        return null;
                      },
                      icon: Icons.calendar_today,
                      hint: "DD/MM/YYYY",
                    ),
                  ),
                ],
              ),
              CustomField(
                title: "Guests".tr(),
                width: double.infinity,
                controller: guests,
                keyboard: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of guests".tr();
                  }
                  return null;
                },
                icon: Icons.people_alt_outlined 
                ,
              ),
              Divider(color: Color(0xffF3F3F5), thickness: 2.h),
              Text(
                "Contact Information".tr(),
                style: TextStyle(color: kBlack, fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              CustomField(
                title: "Full Name".tr(),
                width: double.infinity,
                controller: fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name".tr();
                  }
                  return null;
                },
                hint: "Enter your full name".tr(),
              ),
              CustomField(
                title: "Email".tr(),
                width: double.infinity,
                controller: email,
                keyboard: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email".tr();
                  } else if (!value.contains("@")) {
                    return "Please enter a valid email".tr();
                  }
                  return null;
                },
                hint: "Enter your email".tr(),
              ),
              CustomField(
                title: "Phone Number".tr(),
                width: double.infinity,
                controller: phoneNumber,
                keyboard: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number".tr();
                  } else if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                    return 'Please enter a valid Egyptian phone number'.tr();
                  }
                  return null;
                },
                hint: "Enter your phone number".tr(),
              ),
              CustomButton(
                buttonText: "Complete Booking".tr(),
                icon: Icons.payment,
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
