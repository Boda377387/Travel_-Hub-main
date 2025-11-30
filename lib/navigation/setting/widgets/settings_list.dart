import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        _buildSectionTitle(tr('account'), color: Colors.blueAccent),
        _buildSettingItem(Icons.lock_outline, tr('privacy')),
        _buildSettingItem(Icons.notifications_none, tr('notifications')),
        _buildLanguageItem(context),
         SizedBox(height: 15.h),
        _buildSectionTitle(tr('support'), color: Colors.blueAccent),
        _buildSettingItem(Icons.help_outline, tr('help')),
        _buildSettingItem(Icons.feedback_outlined, tr('feedback')),
         SizedBox(height: 15.h),
        _buildSectionTitle(tr('more'), color: Colors.blueAccent),
        _buildSettingItem(Icons.info_outline, tr('about')),
        _buildSettingItem(Icons.logout, tr('logout'), color: Colors.red),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {Color? color}) {
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(vertical: 8.0.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent),
      title: Text(title, style: TextStyle(color: color)),
      trailing:  Icon(Icons.arrow_forward_ios, size: 16.sp),
      onTap: () {},
    );
  }

  Widget _buildLanguageItem(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language_outlined, color: Colors.blueAccent),
      title: Text(tr('language')),
      trailing:  Icon(Icons.arrow_forward_ios, size: 16.sp),
      onTap: () => _showLanguageDialog(context),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final bgColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            const Icon(Icons.language, color: Colors.blueAccent),
             SizedBox(width: 8.w),
            Text(
              tr('choose_language'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLangOption(
              context,
              label: "English",
              locale: const Locale('en'),
              textColor: textColor,
            ),
            const Divider(),
            _buildLangOption(
              context,
              label: "العربية",
              locale: const Locale('ar'),
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangOption(BuildContext context,
      {required String label,
      required Locale locale,
      required Color textColor}) {
    final isSelected = context.locale == locale;

    return InkWell(
      onTap: () {
        context.setLocale(locale);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding:  EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.blueAccent : textColor.withOpacity(0.6),
              size: 20.sp,
            ),
             SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
