import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';
import 'package:innolab_attendace/utils/constant/size.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';
import 'package:signature/signature.dart'; 

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final controller = AttendanceController();
  
  
  late SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
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
      appBar: AppBar(title: const Text(ATexts.appName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                TextFormField(
                  controller: controller.fullName,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: ATexts.fullName,
                  ),
                ),
                const SizedBox(height: 16),

                
                Text(ATexts.sex, 
                  style: TextStyle(fontSize: ASizes.fontMedium, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Male"),
                        value: 'M',
                        groupValue: controller.selectedSex,
                        onChanged: (value) => setState(() => controller.selectedSex = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Female"),
                        value: 'F',
                        groupValue: controller.selectedSex,
                        onChanged: (value) => setState(() => controller.selectedSex = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                
                TextFormField(
                  controller: controller.office,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building),
                    labelText: "Office / Agency",
                  ),
                ),
                const SizedBox(height: 16),

                
                TextFormField(
                  controller: controller.position,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.briefcase),
                    labelText: "Purpose",
                  ),
                ),
                const SizedBox(height: 16),

                
                TextFormField(
                  controller: controller.contact,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: "Email / Contact Number",
                  ),
                ),
                const SizedBox(height: 24),

                
                const Text("Signature", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Signature(
                    controller: _signatureController,
                    height: 150,
                    backgroundColor: Colors.grey[100]!,
                  ),
                ),
                
                
                TextButton.icon(
                  onPressed: () => _signatureController.clear(),
                  icon: const Icon(Iconsax.eraser, size: 18),
                  label: const Text("Clear Signature"),
                ),

                const SizedBox(height: 32),

                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading 
                    ? null 
                    : () async {
                      if (controller.formKey.currentState!.validate()) {

                        final bytes = await _signatureController.toPngBytes();
                        final message = await controller.submitAttendance(bytes);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );

                        setState(() {});
                      }
                    },
                    child: controller.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit Attendance"), 

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}