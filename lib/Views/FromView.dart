import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Utils/responsive.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _gender = 'Male';
  String? _qualification;
  final Map<String, bool> _skills = {
    'React Native': false,
    'JavaScript': false,
    'TypeScript': false,
    'Node.js': false,
    'Firebase': false,
    'GraphQL': false,
  };

  Future<void> _pickDate() async {
    DateTime today = DateTime.now();
    DateTime maxDate = DateTime(today.year - 13, today.month, today.day);
    DateTime minDate = DateTime(today.year - 80, today.month, today.day);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // colorScheme: ColorScheme.light(
            //   primary: Colors.red,
            //   onPrimary: Colors.white,
            //   onSurface: Colors.red,
            // ),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      List<String> selectedSkills = _skills.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Form Submitted'),
          content: Text(
            'Name: ${_nameController.text}\nDOB: ${_dobController.text}\nGender: $_gender\nQualification: $_qualification\nSkills: ${selectedSkills.join(', ')}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Note Form',
          style: TextStyle(color: Colors.white, fontSize: 15.0.sp),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                onTap: _pickDate,
                validator: (value) =>
                    value!.isEmpty ? 'Please select your date of birth' : null,
              ),
              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile<String>(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: _gender,
                    activeColor: Colors.red,
                    onChanged: (val) => setState(() => _gender = val),
                  ),
                  RadioListTile<String>(
                    title: Text('Female'),
                    value: 'Female',
                    groupValue: _gender,
                    activeColor: Colors.red,
                    onChanged: (val) => setState(() => _gender = val),
                  ),
                  RadioListTile<String>(
                    title: Text('Other'),
                    value: 'Other',
                    groupValue: _gender,
                    activeColor: Colors.red,
                    onChanged: (val) => setState(() => _gender = val),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Qualification
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Qualification',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                items: ['High School', 'Bachelor\'s', 'Master\'s', 'PhD']
                    .map(
                      (qual) =>
                          DropdownMenuItem(value: qual, child: Text(qual)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _qualification = val),
                validator: (value) =>
                    value == null ? 'Please select qualification' : null,
              ),
              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Skills',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._skills.keys.map((skill) {
                    return CheckboxListTile(
                      title: Text(skill),
                      value: _skills[skill],
                      activeColor: Colors.red,
                      onChanged: (val) => setState(() => _skills[skill] = val!),
                    );
                  }).toList(),
                ],
              ),
              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: _submitForm,
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
