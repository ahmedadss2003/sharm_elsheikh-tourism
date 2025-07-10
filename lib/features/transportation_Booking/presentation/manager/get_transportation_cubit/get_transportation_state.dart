part of 'get_transportation_cubit.dart';

@immutable
sealed class GetTransportationState {}

final class GetTransportationInitial extends GetTransportationState {}

final class GetTransportationLoading extends GetTransportationState {}

final class GetTransportationSuccess extends GetTransportationState {
  final List<TransportationModel> transportationModel;
  GetTransportationSuccess(this.transportationModel);
}

final class GetTransportationFailure extends GetTransportationState {
  final String errorMessage;
  GetTransportationFailure(this.errorMessage);
}
