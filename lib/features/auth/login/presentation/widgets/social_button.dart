import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';


class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: color),
        label: Text(text, style: const TextStyle(color: kBlack)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color:kGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
        ),
      ),
    );
  }
}
