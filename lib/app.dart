import 'package:dog_image_generator/dogs/dogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Image Generator',
      home: BlocProvider(
        create: (context) => DogBloc(),
        child: const DogPage(),
      ),
    );
  }
}