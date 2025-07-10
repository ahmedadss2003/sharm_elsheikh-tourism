part of 'tour_by_category_cubit.dart';

@immutable
sealed class TourByCategoryState {}

final class TourByCategoryInitial extends TourByCategoryState {}
final class TourByCategoryLoading extends TourByCategoryState {}
final class TourByCategorySuccess extends TourByCategoryState {
  final List<TourModel> tours ;
  TourByCategorySuccess(this.tours);
}
final class TourByCategoryError extends TourByCategoryState {
  final String errurMsg;
  TourByCategoryError(this.errurMsg);
}
