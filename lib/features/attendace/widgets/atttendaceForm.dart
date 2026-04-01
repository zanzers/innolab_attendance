import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:innolab_attendace/common/style/AttendanceStyles.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';

class Atttendaceform extends StatelessWidget {
  const Atttendaceform({
    super.key,
    required this.controller,
    required this.signatureController,
    required this.isMale,
    required this.isFemale,
    required this.onMaleChanged,
    required this.onFemaleChanged,
  });

  final AttendanceController controller;
  final SignatureController signatureController;
  final bool isMale;
  final bool isFemale;
  final Function(bool) onMaleChanged;
  final Function(bool) onFemaleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. FULL NAME
        Text('FULL NAME', style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.fullName,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration('e.g. Marcelo R. Manzano Jr.'),
        ),

        const SizedBox(height: 16),

        // 2. SEX
        Row(
          children: [
            Text('SEX:', style: AttendanceStyles.labelStyle),
            const SizedBox(width: 20),
            AttendanceStyles.buildSexOption('Male', isMale, onMaleChanged),
            const SizedBox(width: 16),
            AttendanceStyles.buildSexOption('Female', isFemale, onFemaleChanged),
          ],
        ),

        const SizedBox(height: 16),

        // 3. OFFICE / AGENCY
        Text('OFFICE/AGENCY', style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.office,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration('e.g. OVPRED'),
        ),

        const SizedBox(height: 16),

        // 4. EMAIL OR CONTACT NUMBER
        Text('EMAIL or CONTACT NUMBER', style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.contact,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration('e.g. email@wpu.edu.ph'),
        ),

        const SizedBox(height: 16),

        // 5. PURPOSE
        Text('PURPOSE OF VISIT', style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.purpose,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration('e.g. Inquiry / Meeting'),
        ),

        const SizedBox(height: 20),

        // 6. DIGITAL SIGNATURE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('DIGITAL SIGNATURE', style: AttendanceStyles.labelStyle),
            TextButton(
              onPressed: () => signatureController.clear(),
              child: const Text('Clear', style: TextStyle(color: Color(0xFF1A3A6B), fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey.shade300, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              controller: signatureController,
              height: 140,
              backgroundColor: Colors.grey.shade50,
            ),
          ),
        ),
      ],
    );
  }
}