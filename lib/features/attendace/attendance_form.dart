import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/widgets/attendace_appbar.dart';
import 'package:innolab_attendace/features/attendace/widgets/attendace_helper.dart';
import 'package:innolab_attendace/features/attendace/widgets/atttendaceForm.dart';
import 'package:innolab_attendace/features/attendace/widgets/sumit_attendace.dart';
import 'package:signature/signature.dart';
import 'package:innolab_attendace/common/style/AttendanceStyles.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final controller = AttendanceController();
  late SignatureController _signatureController;
  
  bool _isMale = false;
  bool _isFemale = false;
  bool _agreedToPrivacy = false;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            AttendanceAppbar(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleBar(),
                      AttendaceHead(),

                      const SizedBox(height: 24),

                      
                      Atttendaceform(
                        controller: controller,
                        signatureController: _signatureController,
                        isMale: _isMale,
                        isFemale: _isFemale,
                        onMaleChanged: (val) => setState(() {
                          _isMale = val;
                          if (val) _isFemale = false;
                          controller.selectedSex = val ? 'M' : '';
                        }),
                        onFemaleChanged: (val) => setState(() {
                          _isFemale = val;
                          if (val) _isMale = false;
                          controller.selectedSex = val ? 'F' : '';
                        }),
                      ),

                      const SizedBox(height: 20),
                      CheckBox(),
                      const SizedBox(height: 20),
                      PrivacyNotice(labelStyle: AttendanceStyles.labelStyle),
                      const SizedBox(height: 12),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AttendanceStyles.outlineCheckbox(
                            value: _agreedToPrivacy,
                            onChanged: (v) => setState(() => _agreedToPrivacy = v!),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'I have read and agree to the data privacy policy',
                              style: TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      
                      SubmitButtonSection(
                        controller: controller,
                        agreedToPrivacy: _agreedToPrivacy,
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            final bytes = await _signatureController.toPngBytes();
                            final message = await controller.submitAttendance(bytes);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            if (message.contains("Success")) {
                                _signatureController.clear();
                                setState(() {
                                  _isMale = false;
                                  _isFemale = false;
                                  _agreedToPrivacy = false;
                                });
                            }
                            
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}