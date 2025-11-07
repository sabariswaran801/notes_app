import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Controller/FromController.dart';
import 'package:notes_app/Models/PersonModel.dart';
import 'package:sizer/sizer.dart';

class FormScreen extends StatefulWidget {
  final PersonModel? personModel;
  FormScreen({Key? key, this.personModel}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final FormController formController = Get.put(FormController());
  final _formKey = GlobalKey<FormState>();

  Map<String, bool> _skills = {
    'React Native': false,
    'JavaScript': false,
    'TypeScript': false,
    'Node.js': false,
    'Firebase': false,
    'GraphQL': false,
  };

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.personModel != null) {
      PersonModel person = widget.personModel!;
      formController.nameController.text = person.fullName;
      formController.dobController.text = person.dob;
      formController.gender.value = person.gender;
      formController.qualification?.value = person.qualification;

      _skills.updateAll((key, value) => person.skills.contains(key));
    } else {
      formController.nameController.clear();
      formController.dobController.clear();
      formController.gender.value = '';
      formController.qualification?.value = '';
      _skills.updateAll((key, value) => false);
    }
  }

  Future<void> _pickDate() async {
    DateTime today = DateTime.now();
    DateTime maxDate = DateTime(today.year - 13, today.month, today.day);
    DateTime minDate = DateTime(today.year - 80, today.month, today.day);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (picked != null) {
      setState(() {
        formController.dobController.text = DateFormat(
          'dd-MM-yyyy',
        ).format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      List<String> selectedSkills = _skills.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();
      if (widget.personModel != null) {
        formController.updatePerson(widget.personModel?.id, selectedSkills);
      } else {
        formController.createPerson(selectedSkills);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
          borderSide: const BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0.w)),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.0.w,
          vertical: 2.0.h,
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 6.0.w,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Radio<String>(
                    value: option,
                    groupValue: formController.gender.value,
                    activeColor: Colors.red,
                    onChanged: (val) {
                      if (val != null) formController.gender.value = val;
                    },
                  ),
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0.w),
          borderSide: const BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0.w)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.0.w,
          vertical: 2.0.h,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      value: (value ?? '').isEmpty ? null : value,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildSelectableChips(String title, Map<String, bool> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.keys.map((key) {
            final isSelected = options[key]!;
            return InkWell(
              onTap: () {
                setState(() {
                  options[key] = !isSelected;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade400 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Text(
                  key,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Note Form'),
        backgroundColor: Colors.red,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.red.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      controller: formController.nameController,
                      label: 'Full Name',
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: formController.dobController,
                      label: 'Date of Birth',
                      readOnly: true,
                      onTap: _pickDate,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                      ),
                      validator: (val) => val!.isEmpty
                          ? 'Please select your date of birth'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _buildRadioGroup('Gender', ['Male', 'Female', 'Other']),
                    const SizedBox(height: 20),
                    _buildDropdown(
                      label: 'Qualification',
                      items: ['High School', 'Bachelor\'s', 'Master\'s', 'PhD'],
                      value: formController.qualification?.value,
                      onChanged: (val) {
                        if (val != null)
                          formController.qualification?.value = val;
                      },
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please select qualification'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _buildSelectableChips('Skills', _skills),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: Colors.redAccent,
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
