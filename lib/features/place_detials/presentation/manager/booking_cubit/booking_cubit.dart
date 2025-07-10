import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/network/api_service.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final ApiService apiService;
  BookingCubit(this.apiService) : super(BookingInitial());

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      await apiService.bookTour(bookingData);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }
}
