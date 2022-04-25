// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Assistance {
  int id;
  String name;
  String description;
  Assistance({
    required this.id,
    required this.name,
    required this.description,
  });

  Assistance copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Assistance(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Assistance.fromMap(Map<String, dynamic> map) {
    return Assistance(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assistance.fromJson(String source) =>
      Assistance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Assistance(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Assistance &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
