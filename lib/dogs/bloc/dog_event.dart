part of 'dog_bloc.dart';

sealed class DogEvent extends Equatable {
  const DogEvent();

  @override
  List<Object> get props => [];
}

final class DogFetched extends DogEvent {
  const DogFetched(this.breeds);

  final String breeds;

  @override
  List<Object> get props => [breeds];
}