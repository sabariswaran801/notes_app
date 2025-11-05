import 'dart:convert';

List<PersonModel> personModelFromJson(String str) => List<PersonModel>.from(
  json.decode(str).map((x) => PersonModel.fromJson(x)),
);

String personModelToJson(List<PersonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonModel {
  String id;
  String fullName;
  String dob;
  String gender;
  String qualification;
  List<String> skills;

  PersonModel({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.qualification,
    required this.skills,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json["id"],
    fullName: json["fullName"],
    dob: json["dob"],
    gender: json["gender"],
    qualification: json["qualification"],
    skills: List<String>.from(json["skills"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "dob": dob,
    "gender": gender,
    "qualification": qualification,
    "skills": List<dynamic>.from(skills.map((x) => x)),
  };
}
