class Pays {
  final int id;
  final String pays;

  Pays({required this.id, required this.pays});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pays': pays,
    };
  }

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(
      id: json['id'],
      pays: json['pays'],
    );
  }
}


