import 'package:dio/dio.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_constant.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  Future<List<TourModel>> getAllTours() async {
    final Response response = await dio.get("${baseUrl}tours");
    final dataList = response.data['data'];
    if (dataList is List) {
      return List<TourModel>.from(
        dataList.map((x) {
          return TourModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<List<TourModel>> getBestSallerTours() async {
    final Response response = await dio.get("${baseUrl}best-seller-tours");
    final dataList = response.data['data'];

    if (dataList is List) {
      return List<TourModel>.from(
        dataList.map((x) {
          return TourModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<List<TourModel>> searchToursByCategory(String keyword) async {
    final response = await dio.get('$baseUrlForCategory=$keyword');

    final dataList = response.data['data'];

    if (dataList is List) {
      return List<TourModel>.from(dataList.map((x) => TourModel.fromJson(x)));
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    try {
      final Response response = await dio.post(
        "${baseUrl}book-tour",
        data: bookingData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else if (response.statusCode == 301 || response.statusCode == 302) {
        throw Exception('Redirect error: Check backend configuration');
      } else {
        throw Exception(
          'Booking failed with status ${response.statusCode}: ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('There was an error, please Try later!: $e');
    }
  }

  Future<List<TransportationModel>> getTransportation() async {
    final Response response = await dio.get("${baseUrl}transportations");
    final dataList = response.data['data'];
    if (dataList is List) {
      return List<TransportationModel>.from(
        dataList.map((x) {
          return TransportationModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<void> bookTransportation(Map<String, dynamic> bookingData) async {
    try {
      final Response response = await dio.post(
        "${baseUrl}book-transportation",
        data: bookingData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception('Booking failed , please try again');
      }
    } catch (e) {
      throw Exception('There was an error, Please Try later!: $e');
    }
  }
}
