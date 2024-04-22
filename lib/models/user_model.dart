class UserModel {
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String uid;
  UserModel(
      {required this.name,
      required this.imageUrl,
      required this.email,
      required this.phone,
      required this.dateOfBirth,
        required this.uid
      });
  UserModel copyWith(
          {String? name,
          String? imageUrl,
          String? email,
          String? phone,
          DateTime? dateOfBirth,
            String? uid,
          }) =>
      UserModel(
          name: name ?? this.name,
          imageUrl: imageUrl ?? this.imageUrl,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        uid: uid??this.uid
      );
  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
      name: map['name'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      phone: map['phone'],
      dateOfBirth: map['dateOfBirth'].toDate(),
    uid: map['uid']
  );
  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'email': email,
        'phone': phone,
        'dateOfBirth': dateOfBirth,
    'uid':uid,
      };
}
