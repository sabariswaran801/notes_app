import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:notes_app/Utils/responsive.dart';
import 'package:notes_app/Views/FromView.dart';

class FindClassesScreen extends StatefulWidget {
  const FindClassesScreen({Key? key}) : super(key: key);

  @override
  State<FindClassesScreen> createState() => _FindClassesScreenState();
}

class _FindClassesScreenState extends State<FindClassesScreen> {
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  final List<Map<String, dynamic>> classes = [
    {
      'name': 'Sabariswaran',
      'dob': '08/12/2003',
      'gender': 'male',
      'qualification': 'BSc Computer Science',
      'skills': ['React', 'Angular', 'HTML', 'CSS'],
    },
    {
      'name': 'Ananya',
      'dob': '15/03/2002',
      'gender': 'female',
      'qualification': 'B.Tech IT',
      'skills': ['Flutter', 'Dart', 'Firebase'],
    },
    {
      'name': 'Rohit',
      'dob': '22/07/2001',
      'gender': 'male',
      'qualification': 'BCA',
      'skills': ['Java', 'Spring Boot', 'SQL'],
    },
    {
      'name': 'Priya',
      'dob': '30/01/2003',
      'gender': 'female',
      'qualification': 'MCA',
      'skills': ['Python', 'Django', 'REST API'],
    },
    {
      'name': 'Arjun',
      'dob': '12/05/2002',
      'gender': 'male',
      'qualification': 'BSc IT',
      'skills': ['JavaScript', 'Node.js', 'MongoDB'],
    },
    {
      'name': 'Meena',
      'dob': '09/09/2001',
      'gender': 'female',
      'qualification': 'BSc CS',
      'skills': ['C++', 'Data Structures', 'Algorithms'],
    },
    {
      'name': 'Karthik',
      'dob': '18/11/2002',
      'gender': 'male',
      'qualification': 'B.Tech CSE',
      'skills': ['React Native', 'Redux', 'TypeScript'],
    },
    {
      'name': 'Divya',
      'dob': '25/04/2003',
      'gender': 'female',
      'qualification': 'BSc IT',
      'skills': ['Flutter', 'GetX', 'Hive'],
    },
    {
      'name': 'Vignesh',
      'dob': '05/02/2001',
      'gender': 'male',
      'qualification': 'BCA',
      'skills': ['Angular', 'Node.js', 'Express'],
    },
    {
      'name': 'Shalini',
      'dob': '17/08/2002',
      'gender': 'female',
      'qualification': 'BSc Computer Science',
      'skills': ['Python', 'Machine Learning', 'Pandas'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 15.0.wp,
        height: 8.0.hp,
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Get.to(() => FormScreen());
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              height: 30.0.hp,
              width: 100.0.wp,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                image: DecorationImage(
                  image: AssetImage('assets/images/s.png'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp,
                      vertical: 6.0.hp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.search, color: Colors.white, size: 20.0.sp),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 7.0.hp,
                        width: 80.0.wp,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 2.0.wp),
                                Text(
                                  selectedDate == null
                                      ? "Choose Date"
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0.hp),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.0.hp),
          // // List Title
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 4.0.wp),
          //     child: Text(
          //       "List",
          //       style: TextStyle(fontSize: 7.0.sp, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 1.0.hp),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 2.0.hp,
                horizontal: 2.0.wp,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final cls = classes[index];
                return classCard(
                  cls['name'],
                  cls['dob'],
                  cls['gender'],
                  cls['qualification'],
                  cls['skills'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget classCard(
    String name,
    String dob,
    String gender,
    String qualification,
    List skills,
  ) {
    return Container(
      padding: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0.wp),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 10.0.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 0.5.hp),
          Text(
            "DOB: $dob | Gender: $gender",
            style: TextStyle(fontSize: 7.0.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 0.5.hp),
          Text(
            "Qualification: $qualification",
            style: TextStyle(fontSize: 7.5.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 0.5.hp),
          Text(
            "Skills:",
            style: TextStyle(fontSize: 8.0.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.5.hp),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: skills
                    .map<Widget>(
                      (skill) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 8.0.sp,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                  size: 5.0.wp,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
