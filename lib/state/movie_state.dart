// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flutter/models/api.dart';

import '../models/movie.dart';

final moviesProvider = StateNotifierProvider<MoviesNotifier, MovieState>(
    (ref) => MoviesNotifier());

@immutable
abstract class MovieState {}

class InitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;
  MovieLoadedState({
    required this.movies,
  });
}

class ErrorState extends MovieState {
  final String message;
  ErrorState({
    required this.message,
  });
}

class MoviesNotifier extends StateNotifier<MovieState> {
  MoviesNotifier() : super(InitialState());
  HttpGetMovie _httpGetMovie = HttpGetMovie();

  void fetchmovies() async {
    try {
      state = MovieLoadingState();
      List<Movie> movies = await _httpGetMovie.getMovies();
      state = MovieLoadedState(movies: movies);
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}
