// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

class HomeModel {
  List<String> genres;
  List<Movie> movies;

  HomeModel({
    required this.genres,
    required this.movies,
  });

  factory HomeModel.fromJson(String str) => HomeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
    genres: json["genres"] ==[] ? [] : List<String>.from(json["genres"].map((x) => x)),
    movies: json["movies"] ==[] ? [] : List<Movie>.from(json["movies"].map((x) => Movie.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "movies": List<dynamic>.from(movies.map((x) => x.toMap())),
  };
}

class Movie {
  int id;
  String title;
  String year;
  String runtime;
  List<String> genres;
  String director;
  String actors;
  String plot;
  String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.director,
    required this.actors,
    required this.plot,
    required this.posterUrl,
  });

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"]??'',
    year: json["year"]??'',
    runtime: json["runtime"]??'',
    genres: List<String>.from(json["genres"].map((x) => x)),
    director: json["director"]??'',
    actors: json["actors"]??'',
    plot: json["plot"]??'',
    posterUrl: json["posterUrl"]??'',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "year": year,
    "runtime": runtime,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "director": director,
    "actors": actors,
    "plot": plot,
    "posterUrl": posterUrl,
  };
}
