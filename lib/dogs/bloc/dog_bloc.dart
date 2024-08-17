import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'dog_event.dart';
part 'dog_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc() : super(const DogState()) {
    on<DogFetched>(
      _onDogFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onDogFetched(
    DogFetched event,
    Emitter<DogState> emit,
  ) async {
    try {
      if (state.status == DogStatus.initial || state.status == DogStatus.success) {
        final image = await _fetchDog(event.breeds);
        return emit(state.copyWith(
          status: DogStatus.success,
          image: image,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: DogStatus.failure));
    }
  }

  Future<String> _fetchDog(String breeds) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breeds/images/random'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json['message'] as String;
    } else {
      throw Exception('Failed to fetch dog image.');
    }
  }
}
