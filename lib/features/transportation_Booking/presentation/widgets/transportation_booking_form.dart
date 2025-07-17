import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';

class TransportBookingForm extends StatefulWidget {
  const TransportBookingForm({super.key, required this.transportationModel});
  final TransportationModel transportationModel;
  static const routeName = 'transportation-booking-form';
  @override
  TransportBookingScreenState createState() => TransportBookingScreenState();
}

class TransportBookingScreenState extends State<TransportBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _numberOfPeopleController = TextEditingController();
  final _messageController = TextEditingController();
  DateTime? _departureDate;
  TimeOfDay? _departureTime;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _numberOfPeopleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    int numberOfPeople = int.tryParse(_numberOfPeopleController.text) ?? 0;
    double basePrice = widget.transportationModel.price;
    return numberOfPeople * basePrice;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final bookingData = {
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'number_of_people': int.tryParse(_numberOfPeopleController.text) ?? 0,
        'message': _messageController.text,
        'departure_date': _departureDate?.toIso8601String().split('T').first,
        'departure_time':
            _departureTime != null
                ? '${_departureTime!.hour.toString().padLeft(2, '0')}:${_departureTime!.minute.toString().padLeft(2, '0')}'
                : null,
        'transportation_id': widget.transportationModel.id,
        'total_price': _calculateTotalPrice(),
      };

      context.read<TransportationBookingCubit>().bookTransportation(
        bookingData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0F7FA), Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: BlocConsumer<TransportationBookingCubit, BookingState>(
                  listener: (context, state) {
                    if (state is BookingSuccess) {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        title: "Success",
                        desc: "This Transportation Booking Successfully",
                        dialogType: DialogType.success,
                        btnOkOnPress: () {},
                      ).show();
                    } else if (state is BookingFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking failed: ${state.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Starting at £${widget.transportationModel.price} ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Per Person',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'John Doe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator:
                                (value) =>
                                    value?.isEmpty ?? true
                                        ? 'This field is required.'
                                        : null,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'sample@yourcompany.com',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'This field is required.';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value!)) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+66-4353434',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator:
                                (value) =>
                                    value?.isEmpty ?? true
                                        ? 'This field is required.'
                                        : null,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _numberOfPeopleController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Number of People',
                              hintText: '2',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'This field is required.';
                              }
                              if (int.tryParse(value!) == null ||
                                  int.parse(value) <= 0) {
                                return 'Please enter a valid number of people.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(
                                () {},
                              ); // Trigger rebuild to update total price
                            },
                          ),
                          SizedBox(height: 15),
                          // DropdownButtonFormField<String>(
                          //   decoration: InputDecoration(
                          //     labelText: 'Interested In',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          //   value: _interestedIn,
                          //   hint: Text('Select an option'),
                          //   items:
                          //       [
                          //         'Airport to Hotel 25€',
                          //         'Sharm El Sheikh to Cairo',
                          //         'Cairo to Old Market',
                          //         'Soho Square to Dahab',
                          //       ].map((String value) {
                          //         return DropdownMenuItem<String>(
                          //           value: value,
                          //           child: Text(value),
                          //         );
                          //       }).toList(),
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       _interestedIn = newValue;
                          //     });
                          //   },
                          //   validator:
                          //       (value) =>
                          //           value == null
                          //               ? 'This field is required.'
                          //               : null,
                          // ),
                          SizedBox(height: 15),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Departure Date',
                              hintText: 'mm/dd/yyyy',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2026),
                              );
                              if (picked != null) {
                                setState(() {
                                  _departureDate = picked;
                                });
                              }
                            },
                            controller: TextEditingController(
                              text:
                                  _departureDate != null
                                      ? '${_departureDate!.month}/${_departureDate!.day}/${_departureDate!.year}'
                                      : '',
                            ),
                            validator:
                                (value) =>
                                    _departureDate == null
                                        ? 'This field is required.'
                                        : null,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Departure Time',
                              hintText: 'HH:MM',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.access_time),
                            ),
                            onTap: () async {
                              TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _departureTime = picked;
                                });
                              }
                            },
                            controller: TextEditingController(
                              text:
                                  _departureTime != null
                                      ? '${_departureTime!.hour.toString().padLeft(2, '0')}:${_departureTime!.minute.toString().padLeft(2, '0')}'
                                      : '',
                            ),
                            validator:
                                (value) =>
                                    _departureTime == null
                                        ? 'This field is required.'
                                        : null,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _messageController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Message (Optional)',
                              hintText:
                                  'Enter any additional information or special requests...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '€${_calculateTotalPrice().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed:
                                state is BookingLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child:
                                  state is BookingLoading
                                      ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Text(
                                        'Book Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
