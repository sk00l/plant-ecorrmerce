import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDetails {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String uid;
  UserDetails({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.uid,
  });

  UserDetails copyWith({
    String? fname,
    String? lname,
    String? email,
    String? password,
    String? uid,
  }) {
    return UserDetails(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'uid': uid,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      fname: map['fname'] as String,
      lname: map['lname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetails(fname: $fname, lname: $lname, email: $email, password: $password, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserDetails other) {
    if (identical(this, other)) return true;

    return other.fname == fname &&
        other.lname == lname &&
        other.email == email &&
        other.password == password &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return fname.hashCode ^
        lname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        uid.hashCode;
  }
}
