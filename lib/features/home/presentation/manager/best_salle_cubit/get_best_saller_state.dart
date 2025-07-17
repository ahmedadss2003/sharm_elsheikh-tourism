part of 'get_best_saller_cubit.dart';

@immutable
sealed class GetAllToursState {}

final class GetAllTourInitial extends GetAllToursState {}

final class GetAllTourLoading extends GetAllToursState {}

final class GetAllTourSuccess extends GetAllToursState {
  final List<TourModel> tourList;
  GetAllTourSuccess(this.tourList);
}

final class GetAllTourError extends GetAllToursState {
  final String message;
  GetAllTourError(this.message);
}
