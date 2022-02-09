import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_api_project/home/bloc/bloc/home_bloc.dart';
import 'package:sample_api_project/services/boredService.dart';
import 'package:sample_api_project/services/connectivityService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityService>(context))
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.activityName),
                    Text(state.activityType),
                    Text(state.participants.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () => BlocProvider.of<HomeBloc>(context)
                            .add(LoadApiEvent()),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              );
            }
            if (state is HomeNoInternetState) {
              return const Center(child: Text("No Internet"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
