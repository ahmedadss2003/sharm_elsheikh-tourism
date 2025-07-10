import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/custom_date_picker.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/custom_number_selector.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/custom_text_form_field.dart';

class BookingFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime? selectedDate;
  final int adults;
  final int children;
  final Animation<Offset> slideAnimation;
  final Function(DateTime?) onDateChanged;
  final Function(int) onAdultsChanged;
  final Function(int) onChildrenChanged;

  const BookingFormCard({
    super.key,
    required this.formKey,
    required this.selectedDate,
    required this.adults,
    required this.children,
    required this.slideAnimation,
    required this.onDateChanged,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.blue[50]!],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: Colors.blue[100]!, width: 1),
        ),
        child: BlocProvider(
          create: (context) => BookingCubit(ApiService(Dio())),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '\$120 ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[600]!, Colors.red[500]!],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Book This Adventure',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: 'Full Name',
                  icon: Icons.person,
                  hintText: 'John Doe',
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'Email Address',
                  icon: Icons.email,
                  hintText: 'john@example.com',
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'WhatsApp Number',
                  icon: Icons.phone,
                  hintText: '+201068561700',
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'Hotel Name',
                  icon: Icons.hotel,
                  hintText: 'Hilton Waterfront',
                ),
                const SizedBox(height: 15),
                CustomDatePicker(
                  selectedDate: selectedDate,
                  onDateChanged: onDateChanged,
                ),
                const SizedBox(height: 15),
                CustomNumberSelector(
                  label: 'Adults',
                  value: adults,
                  onChanged: onAdultsChanged,
                ),
                const SizedBox(height: 15),
                CustomNumberSelector(
                  label: 'Children',
                  value: children,
                  onChanged: onChildrenChanged,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[600]!, Colors.cyan[500]!],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$${(adults * 120 + children * 60).toString()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.orange.withOpacity(0.4),
                      elevation: 6,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Handle booking logic
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.rocket_launch, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'Book Your Adventure',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Why Choose Us?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.price_check,
                            color: Colors.green[600],
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          const Expanded(child: Text('Best price guarantee')),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Colors.green[600],
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          const Expanded(child: Text('24/7 customer support')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
