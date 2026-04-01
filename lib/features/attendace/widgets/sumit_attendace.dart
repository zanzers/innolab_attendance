import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';

class SubmitButtonSection extends StatelessWidget {
  final AttendanceController controller;
  final bool agreedToPrivacy;
  final VoidCallback? onPressed;

  const SubmitButtonSection({
    super.key,
    required this.controller,
    required this.agreedToPrivacy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A2E),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF1A1A2E).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        // Disable button if not agreed to privacy OR if already loading
        onPressed: (!agreedToPrivacy || controller.isLoading) ? null : onPressed,
        child: controller.isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                'SUBMIT ATTENDANCE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}