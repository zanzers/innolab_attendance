

import 'package:flutter/material.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';

class PrivacyNotice extends StatelessWidget {
  const PrivacyNotice({
    super.key,
    required TextStyle labelStyle,
  }) : _labelStyle = labelStyle;

  final TextStyle _labelStyle;

  @override
  Widget build(BuildContext context) {
    return Text('Privacy Notice', style: _labelStyle);
  }
}


class CheckBox extends StatelessWidget {
  const CheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const SingleChildScrollView(
        child: Text(
          ATexts.privacyNotice,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}


class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ATTENDANCE FORM',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}



class AttendaceHead extends StatelessWidget {
  const AttendaceHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'OFFICE OF THE VICE PRESIDENT FOR THE\nRESEARCH DEVELOPMENT & EXTENTION',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9,
          color: Colors.grey,
          letterSpacing: 0.3,
          height: 1.5,
        ),
      ),
    );
  }
}







