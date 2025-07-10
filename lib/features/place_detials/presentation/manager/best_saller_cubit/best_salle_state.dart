part of 'best_salle_cubit.dart';

@immutable
sealed class BestSalleState {}

final class BestSalleInitial extends BestSalleState {}

final class BestSalleLoading extends BestSalleState {}

final class BestSalleSuccess extends BestSalleState {
  final List<TourModel> tours;
  BestSalleSuccess(this.tours);
}

final class BestSalleError extends BestSalleState {
  final String message;
  BestSalleError(this.message);
}
