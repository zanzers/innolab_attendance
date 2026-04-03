
import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';


class UserTimeView extends StatelessWidget {
  final AttendanceController controller;

  const UserTimeView({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 16),

        Text(
          'Checked In Successfully',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
        ),

        const SizedBox(height: 8),
        Text(
          'Welcome,  ${controller.fullName.text}',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const Divider(height: 40),
        const Text(
          'Please click the button below before you leave the premises to record your TIime-Out.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black45),
        ),
        const SizedBox(height: 32),

        controller.isLoading
           ? const CircularProgressIndicator()
           : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () async {
                final message = await controller.handleTimeOut();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              },
              child: const Text('Time-Out/Leave', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () => controller.forceReset(),
            child: const Text('Not you? Tap to restart form'),
          ),

      ],
    );
  }
}