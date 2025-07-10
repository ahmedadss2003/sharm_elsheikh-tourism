import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  static const String routeName = 'contact_us_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          final isDesktop = constraints.maxWidth >= 900;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(isMobile, isTablet, isDesktop),
                    _buildContactSection(isMobile, isTablet, isDesktop),
                    // _buildMapSection(isMobile, isTablet, isDesktop),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              // _buildStickyHeader(isMobile, isTablet, isDesktop),
            ],
          );
        },
      ),
    );
  }



  Widget _buildHeader(bool isMobile, bool isTablet, bool isDesktop) {
    return Container(
      height: isMobile ? 200 : isTablet ? 250 : 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Contact Us',
            style: TextStyle(
              fontSize: isMobile ? 28 : isTablet ? 36 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(bool isMobile, bool isTablet, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 15 : isTablet ? 20 : 30),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildContactInfo(),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 1,
                  child: _buildContactForm(),
                ),
              ],
            )
          : Column(
              children: [
                _buildContactInfo(),
                const SizedBox(height: 30),
                _buildContactForm(),
              ],
            ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 20),
        _buildContactItem(Icons.location_on, '123 Travel Street, Sharm El Sheikh, Egypt'),
        _buildContactItem(Icons.email, 'info@toursite.com'),
        _buildContactItem(Icons.phone, '+20 123 456 7890'),
        _buildContactItem(Icons.access_time, 'Mon-Fri: 9:00 AM - 6:00 PM'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Us a Message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField('Full Name', Icons.person, 'John Doe'),
          const SizedBox(height: 15),
          _buildFormField('Email Address', Icons.email, 'john@example.com'),
          const SizedBox(height: 15),
          _buildFormField('Subject', Icons.subject, 'Your Subject'),
          const SizedBox(height: 15),
          _buildFormField('Message', Icons.message, 'Your message here...', maxLines: 5),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                
              },
              child: const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon, String hintText, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.blue[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            fillColor: Colors.white,
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

}