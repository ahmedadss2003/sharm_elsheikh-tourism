import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';

part 'get_transportation_state.dart';

class GetTransportationCubit extends Cubit<GetTransportationState> {
  final ApiService apiService;
  GetTransportationCubit(this.apiService) : super(GetTransportationInitial());

  Future<void> getTransportation() async {
    emit(GetTransportationLoading());
    try {
      final transportation = await apiService.getTransportation();
      emit(GetTransportationSuccess(transportation));
    } catch (e) {
      emit(GetTransportationFailure(e.toString()));
    }
  }
}
