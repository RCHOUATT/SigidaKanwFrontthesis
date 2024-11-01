class GenreUser {
  final int id;
  final String genre;

  GenreUser({required this.id, required this.genre});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'genre': genre,
    };
  }

  factory GenreUser.fromJson(Map<String, dynamic> json) {
    return GenreUser(
      id: json['id'],
      genre: json['genre'],
    );
  }
}


