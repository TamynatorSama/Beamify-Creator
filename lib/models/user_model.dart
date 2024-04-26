class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;
  final bool isCreator;
  final String beamifyCredit;

  const UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.isCreator,
      this.avatar,
      required this.beamifyCredit,
      required this.id});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      isCreator: json["is_creator"],
      avatar: json["avatar"],
      beamifyCredit: json["beamify_credit"],
      id: json["id"]);
}
