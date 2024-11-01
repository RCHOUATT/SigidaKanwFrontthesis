class Langues {
  final int id;
  final String apropos;
  final String nom;

  Langues({
    required this.id,
    required this.apropos,
    required this.nom,
  });

  // Method to serialize the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apropos': apropos,
      'nom': nom,
    };
  }

  // Factory method to create an instance from JSON
  factory Langues.fromJson(Map<String, dynamic> json) {
    try {
      return Langues(
        id: json['id'] ?? 0, // Provide a default value if null
        apropos: json['apropos'] ?? '', // Provide an empty string if null
        nom: json['nom'] ?? '', // Provide an empty string if null
      );
    } catch (e) {
      print('Error parsing Langues: $e');
      return Langues(id: 0, apropos: '', nom: ''); // Return a default instance on error
    }
  }
}
