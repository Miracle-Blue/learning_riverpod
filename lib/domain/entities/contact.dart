class Contact {
  String id;
  String number;
  String name;

  Contact({
    required this.id,
    required this.number,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'name': name,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
    );
  }
}
