class NewUserModel {
  String? name;
  int? age; // Now explicitly using `int`
  String? uid;

  NewUserModel({
    required this.name,
    this.uid,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'age': age,
    };
  }

  factory NewUserModel.fromMap(Map<String, dynamic> data) {
    return NewUserModel(
      name: data['name'] as String?,
      age: data['age'] != null ? int.tryParse(data['age'].toString()) : null, // Convert to int
      uid: data['uid'] as String?,
    );
  }
}
