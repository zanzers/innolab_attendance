import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/validation_widget/validation_form.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';
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
    required this.contactFocusNode,
  });

  final AttendanceController controller;
  final FocusNode contactFocusNode;
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

   
        Text(ATexts.fullName, style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.fullName,
          inputFormatters: [
            FormValidation.capitalizeWords(),
            FormValidation.blockLeadingZeros()
            ],
          validator: FormValidation.validateFullName,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration(ATexts.nameDecorator).copyWith(
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
          
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Text(ATexts.sex, style: AttendanceStyles.labelStyle),
            const SizedBox(width: 20),
            AttendanceStyles.buildSexOption('Male', isMale, onMaleChanged),
            const SizedBox(width: 16),
            AttendanceStyles.buildSexOption('Female', isFemale, onFemaleChanged),
          ],
        ),

        if(controller.hasAttemptedSubmit && controller.selectedSex.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(ATexts.errorSex, style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
        
        const SizedBox(height: 16),

        Text(ATexts.officeAgencyDecorator, style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.office,
          inputFormatters: [
            FormValidation.capitalizeWords(),
            FormValidation.blockLeadingZeros()
            ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) => FormValidation.validateRequired(val, ATexts.errorOffice),
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration('e.g. OVPRED').copyWith(
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),

        const SizedBox(height: 16),

        Text(ATexts.emailContactDecorator, style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.contact,
          focusNode: contactFocusNode,
          inputFormatters: [ 
            FormValidation.contactFormatter()
            ],
          validator: (val) {
            if(val == null || val.isEmpty) return ATexts.errorContact;

            String cleanVal = val.trim();

            if(cleanVal.startsWith('+')) {
              if(cleanVal.length < 15) {
                return ATexts.errorContactLength;
              }
            } else if(!cleanVal.contains('@') && !RegExp(r'^\+?\d+$').hasMatch(cleanVal)) {
              return ATexts.errorContact;
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration(ATexts.emailDecorator1).copyWith(
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),

        const SizedBox(height: 16),

        Text(ATexts.purposeDecorator, style: AttendanceStyles.labelStyle),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.purpose,
          inputFormatters: [
            FormValidation.capitalizeWords(),
            FormValidation.blockLeadingZeros()
            ],
          validator: (val) => FormValidation.validateRequired(val, ATexts.errorPurpose),
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          decoration: AttendanceStyles.fieldDecoration(ATexts.purposeDecorator1).copyWith(
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ATexts.signatureDecorator, style: AttendanceStyles.labelStyle),
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
            border: Border.all(
              color: (controller.hasAttemptedSubmit && signatureController.isEmpty) 
              ? Colors.red
              : Colors.grey.shade300,
            width: 0.8
              ),
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
        if(controller.hasAttemptedSubmit && signatureController.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(ATexts.errorSignature, style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }
}