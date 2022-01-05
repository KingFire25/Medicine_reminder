final String tablenotes = 'notes';

class Notesfield {
  static final List<String> values = [id, name];
  static final String id = '_id';
  static final String name = 'name';
}

class Notes {
  final int? id;
  final String name;

  const Notes({
    this.id,
    required this.name,
  });

  Notes copy({
    int? id,
    String? name,
  }) =>
      Notes(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static Notes fromJson(Map<String, Object?> json) => Notes(
        id: json[Notesfield.id] as int?,
        name: json[Notesfield.name] as String,
      );

  Map<String, Object?> toJson() => {
        Notesfield.id: id,
        Notesfield.name: name,
      };
}
