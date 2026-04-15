class UserEntity {
  final String id;
  final String email;

  const UserEntity({required this.id, required this.email});

  Map<String, dynamic> toMap() => {"id": id, "email": email};

  factory UserEntity.fromMap(Map<String, dynamic> json) =>
      UserEntity(
        id: json["id"] ?? "0",
        email: json["email"] ?? "" 
      );
}
