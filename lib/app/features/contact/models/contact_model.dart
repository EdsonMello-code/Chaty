class ContactModel {
  final String name;
  final int? id;
  final String email;
  final String? avatarPath;

  const ContactModel(
      {this.id, required this.name, required this.email, this.avatarPath});

  factory ContactModel.fromMap({required Map<String, dynamic> map}) {
    return ContactModel(
        name: map['name'],
        email: map['email'],
        avatarPath: map['avatarPath'],
        id: map['id']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map();
    map['name'] = name;
    map['email'] = email;
    map['avatarPath'] = avatarPath;
    map['id'] = id;
    return map;
  }
}
