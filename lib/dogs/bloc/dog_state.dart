part of 'dog_bloc.dart';

enum DogStatus { initial, success, failure }

final class DogState extends Equatable {
  const DogState({
    this.status = DogStatus.initial,
    this.image = '',
  });

  final DogStatus status;
  final String? image;

  DogState copyWith({
    DogStatus? status,
    String? image,
  }) {
    return DogState(
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [status, image];
}
