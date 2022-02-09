import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_api_project/home/bloc/bloc/home_bloc.dart';
import 'package:sample_api_project/services/boredService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(RepositoryProvider.of<BoredService>(context))
            ..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("How bored people chill out"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                children: [
                  Text(state.activityName),
                  Text(state.activityType),
                  Text(state.participants.toString()),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
