import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:notes_app/Views/PersonList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes - App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: PersonList(),
    );
  }
}
