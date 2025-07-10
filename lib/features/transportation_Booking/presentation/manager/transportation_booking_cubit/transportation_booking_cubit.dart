import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/network/api_service.dart';

part 'transportation_booking_state.dart';

class TransportationBookingCubit extends Cubit<BookingState> {
  final ApiService apiService;
  TransportationBookingCubit(this.apiService) : super(BookingInitial());

  Future<void> bookTransportation(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());
    try {
      await apiService.bookTransportation(bookingData);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure(message: e.toString()));
    }
  }
}
