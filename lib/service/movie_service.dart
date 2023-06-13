import 'dart:convert';
import 'dart:developer';

import 'package:movie_flutter/models/movie.dart';
import 'package:http/http.dart' as http;

class HttpGetMovie {
  static const String _baseUrl = 'https://api.themoviedb.org';
  static const String _endpoint =
      '/3/movie/popular?api_key=2f9ec8b17725ce7d200b06b69a98ade8';

  Future<List<Movie>> getMovies() async {
    List<Movie> movies = [];
    try {
      Uri movieUri = Uri.parse('$_baseUrl$_endpoint');
      http.Response response = await http.get(movieUri);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> movieList = jsonData["results"];
        for (var movieListItem in movieList) {
          Movie movie = Movie.fromJson(movieListItem);
          movies.add(movie);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return movies;
  }
}






// import 'dart:convert';

// import 'movie.dart';
// import 'package:http/http.dart' as http;

// Future<List<Movie>> getMovies(String apiKey) async {
//   const url = 'https://api.themoviedb.org/3/movie/popular?api_key={apiKey}';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     final json = jsonDecode(response.body);
//     return (json as List).map((e) => Movie.fromJson(e)).toList();
//   } else {
//     throw Exception('Failed to retrieve the movie list');
//   }
// }
//2f9ec8b17725ce7d200b06b69a98ade8