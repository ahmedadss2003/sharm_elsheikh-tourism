part of 'transportation_booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingSuccess extends BookingState {}

final class BookingFailure extends BookingState {
  final String message;
  BookingFailure({required this.message});
}
