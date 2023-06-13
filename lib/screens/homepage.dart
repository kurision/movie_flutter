import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutter/state/movie_state.dart';

import '../models/movie.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies App"),
        centerTitle: true,
      ),
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          MovieState state = ref.watch(moviesProvider);
          if (state is InitialState) {
            return const Text("Press button to fetch data");
          }
          if (state is MovieLoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is ErrorState) {
            return Text(state.message);
          }
          if (state is MovieLoadedState) {
            return _buildListView(state);
          }
          return const Text("No data found");
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(moviesProvider.notifier).fetchmovies();
        },
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildListView(MovieLoadedState state) {
    return Flexible(
      child: ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            Movie movie = state.movies[index];
            return Center(
              child: Card(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                        width: 120,
                        height: 185,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        children: [
                          Text(movie.title),
                          Text(
                            DateFormat('MMMM dd, yyyy')
                                .format(DateTime.parse('${movie.releaseDate}')),
                          ),
                        ],
                      )
                    ]),
                    Text(
                      movie.overview,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
//https://image.tmdb.org/t/p/w200/${movie.posterPath}