class UserModel {
  String? phoneNumber;
  String? uid;

  UserModel({
    required this.phoneNumber,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }

  // Factory constructor to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] as String?,
      uid: map['uid'] as String?,
    );
  }
}
