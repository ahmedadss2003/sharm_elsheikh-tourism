import 'package:flutter/material.dart';
import 'package:tourist_website/core/widgets/similar_and_most_popular_card.dart';

class PlaceDetailsView extends StatefulWidget {
  const PlaceDetailsView({super.key});
  static const String routeName = 'place_details_view';

  @override
  _PlaceDetailsViewState createState() => _PlaceDetailsViewState();
}

class _PlaceDetailsViewState extends State<PlaceDetailsView> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  int adults = 1;
  int children = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80), // Space for sticky header
                _buildHeroSection(),
                _buildMainContent(),
                _buildSimilarTours(),
              ],
            ),
          ),
          _buildHeader(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TourSite',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
                letterSpacing: 1.2,
              ),
            ),
            MediaQuery.of(context).size.width > 600
                ? Row(
                    children: [
                      _buildNavItem('Home', () {}),
                      _buildNavItem('Tours', () {}),
                      _buildNavItem('Destinations', () {}),
                      _buildNavItem('Contact', () {}),
                      _buildNavItem('About', () {}),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.menu, color: Colors.blue),
                    onPressed: () {
                      // Open drawer or menu
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          // Parallax Background
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.blue[900]!.withOpacity(0.7),
                ],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Swimming with Dolphins',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Sharm El Sheikh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      children: [
                        _buildInfoChip(Icons.access_time, '8 Hours'),
                        _buildInfoChip(Icons.group, 'Small Group'),
                        _buildInfoChip(Icons.star, '4.8 Rating'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.white],
        ),
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildTourDetails()),
                const SizedBox(width: 30),
                Expanded(flex: 1, child: _buildBookingForm()),
              ],
            )
          : Column(
              children: [
                _buildTourDetails(),
                const SizedBox(height: 30),
                _buildBookingForm(),
              ],
            ),
    );
  }

  Widget _buildTourDetails() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This Tour',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Swimming with dolphins in Sharm el Sheikh is a unique experience at Dolphin World, showcasing a culture of excellence. Interact closely with these intelligent creatures, swim with them, and feel the hope they inspire.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Text(
              'Explore Ras Kanaysi Marine National Park, home to colorful fish like rays, groupers, angelfish, and stunning coral gardens.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Text(
              'Enjoy an outdoor adventure, dancing and swimming with dolphins, guided by our experts who share insights on their connection with humans.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Text(
              'Transfer service available',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Text(
              'Conclude your day with a taste of Egyptian theater and lunch at Dolphin World.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
            ),
            const SizedBox(height: 30),
            _buildPricingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Departure Time',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              const Text('7:00 AM'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Return Time',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              const Text('5:00 PM'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book This Tour',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),
            _buildFormField('Full Name', Icons.person),
            const SizedBox(height: 15),
            _buildFormField('Email Address', Icons.email),
            const SizedBox(height: 15),
            _buildFormField('Phone Number', Icons.phone),
            const SizedBox(height: 15),
            _buildDateField(),
            const SizedBox(height: 15),
            _buildNumberField('Adults', adults, (value) {
              setState(() {
                adults = value;
              });
            }),
            const SizedBox(height: 15),
            _buildNumberField('Children', children, (value) {
              setState(() {
                children = value;
              });
            }),
            const SizedBox(height: 15),
            _buildFormField('Additional Requirements', Icons.note, maxLines: 3),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.red.withOpacity(0.4),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking submitted successfully!')),
                    );
                  }
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'For More Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[600], size: 16),
                const SizedBox(width: 8),
                const Text('Free cancellation'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[600], size: 16),
                const SizedBox(width: 8),
                const Text('Best price guarantee'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.blue[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            fillColor: Colors.grey[50],
            filled: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Colors.blue[900]!,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue[600]),
                const SizedBox(width: 12),
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select a date',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              Icon(Icons.group, color: Colors.blue[600]),
              const SizedBox(width: 12),
              Expanded(child: Text(value.toString(), style: const TextStyle(fontSize: 16))),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.red[600],
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green[600],
                onPressed: () => onChanged(value + 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarTours() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore Similar Tours',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Transform.scale(
                scale: 1.0,
                child: SimilarAndMostPopularCard(index: index),
              );
            },
          ),
        ],
      ),
    );
  }
}