import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controller/FromController.dart';
import 'package:notes_app/Views/FromView.dart';
import 'package:sizer/sizer.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final FormController formController = Get.put(FormController());
  DateTime? selectedDate;

  // Future<void> _pickDate() async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null) {
  //     setState(() => selectedDate = picked);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    formController.getAllPersonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              height: 30.0.h,
              width: 100.0.w,
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
                      horizontal: 5.0.w,
                      vertical: 6.0.h,
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
                      // onTap: _pickDate,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 7.0.h,
                        width: 80.0.w,
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
                                SizedBox(width: 2.0.w),
                                Text(
                                  selectedDate == null
                                      ? "Choose Date"
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0.sp,
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
                  SizedBox(height: 3.0.h),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.0.h),

          Expanded(
            child: Obx(() {
              if (formController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }

              final personList = formController.personData;

              if (personList.isEmpty) {
                return const Center(
                  child: Text(
                    "No Records Found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: personList.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0.w,
                  vertical: 2.0.h,
                ),
                itemBuilder: (context, index) {
                  final data = personList[index];
                  return InkWell(
                    onTap: () => Get.to(() => FormScreen(personModel: data)),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.0.h),
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

      floatingActionButton: SizedBox(
        width: 15.0.w,
        height: 8.0.h,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.red,
          onPressed: () => Get.to(() => FormScreen()),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
      padding: EdgeInsets.all(3.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0.w),
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
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () async {
                  bool? confirm = await Get.dialog(
                    AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                        "Are you sure you want to delete this record?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    formController.deletePerson(id);
                  }
                },
                icon: Icon(Icons.delete, color: Colors.red, size: 4.0.w),
              ),
            ],
          ),

          Text(
            "DOB: $dob | Gender: $gender",
            style: TextStyle(fontSize: 14.0.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 0.5.h),
          Text(
            "Qualification: $qualification",
            style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 0.5.h),
          Text(
            "Skills:",
            style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.5.h),
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
                        fontSize: 14.0.sp,
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
