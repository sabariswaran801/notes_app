import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controller/FromController.dart';
import 'package:notes_app/Utils/responsive.dart';
import 'package:notes_app/Views/FromView.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final FormController formController = Get.put(FormController());
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

  @override
  void initState() {
    formController.getAllPersonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 15.0.wp,
        height: 8.0.hp,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () => Get.to(() => FormScreen()),
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
                // color: Color(0xFFE53935),
                // image: DecorationImage(
                //   image: AssetImage('assets/images/s.png'),
                //   fit: BoxFit.cover,
                //   opacity: 0.2,
                // ),
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
          Expanded(
            child: Obx(() {
              final personList = formController.personData;
              if (formController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }
              if (personList.isEmpty) {
                return Center(child: Text("No Records Found"));
              }
              return ListView.builder(
                itemCount: personList.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0.wp,
                  vertical: 2.0.hp,
                ),
                itemBuilder: (context, index) {
                  final data = personList[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => FormScreen(personModel: data));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.0.hp),
                      child: classCard(
                        data.id,
                        data.fullName,
                        data.dob,
                        data.gender,
                        data.qualification,
                        data.skills,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget classCard(
    String id,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () {
                  formController.deletePerson(id);
                },
                icon: Icon(Icons.delete, color: Colors.red, size: 3.0.wp),
              ),
            ],
          ),
          // SizedBox(height: 0.5.hp),
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
          Wrap(
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
        ],
      ),
    );
  }
}
