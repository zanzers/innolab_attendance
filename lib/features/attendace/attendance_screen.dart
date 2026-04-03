import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/widgets/attendace_appbar.dart';
import 'package:innolab_attendace/features/attendace/widgets/attendace_helper.dart';
import 'package:innolab_attendace/features/attendace/widgets/atttendaceForm.dart';
import 'package:innolab_attendace/features/attendace/widgets/sumit_attendace.dart';
import 'package:innolab_attendace/features/attendace/widgets/userTimeView.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';
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
  final FocusNode _contactFocusNode = FocusNode();
  late SignatureController _signatureController;
  
  bool _isMale = false;
  bool _isFemale = false;
  bool _agreedToPrivacy = false;

  @override
  void initState() {
    super.initState();

    controller.hasAttemptedSubmit = false;
    _contactFocusNode.addListener((){
      if(!_contactFocusNode.hasFocus){
        String val = controller.contact.text.trim();

        if(val.startsWith('09') && val.length == 11){
          String transformed = '+63 9{val.substring(2)}';

          setState(() {
            controller.contact.text = transformed;
            controller.formKey.currentState?.validate();
            });
        }
        else if(val.startsWith('9') && val.length == 10){
          String transformed = '+63 9{val.substring(1)}';

          setState(() => controller.contact.text = transformed);
        }
      }
    });

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

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          switchInCurve: Curves.easeOutBack,
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.5, 0.5),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child
                                ),
                            );
                          },
                        child: controller.isUserCheckedIn
                            ? UserTimeView(controller: controller)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                                  Atttendaceform(
                                    controller: controller,
                                    contactFocusNode: _contactFocusNode,
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
                                          ATexts.iRead,
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
                                      setState(() => controller.hasAttemptedSubmit = true);

                                      if (controller.formKey.currentState!.validate()) {
                                          
                                          if(controller.selectedSex.isEmpty || _signatureController.isEmpty){
                                            return;
                                          }

                                        final bytes = await _signatureController.toPngBytes();
                                        final message = await controller.submitAttendance(bytes);

                                        if (mounted) {

                                          controller.fullName.clear();
                                            controller.contact.clear();
                                            _signatureController.clear();
                                            
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(message)),
                                          );
                              
                                         
                                          if (message.contains("Success") || message.contains('You have already checked in for today.')){
                                            
                                            
                                            
                                            setState(() {
                                              _isMale = false;
                                              _isFemale = false;
                                              _agreedToPrivacy = false;


                                              controller.hasAttemptedSubmit = false; 
                                              controller.selectedSex = "";
                                            });
                                            controller.formKey.currentState?.reset();
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ), 
                          )

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