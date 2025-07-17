import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/home/presentation/widgets/youtube_section.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/best_salling_grid_view.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/custom_text_form_field.dart';
import 'package:tourist_website/features/place_detials/presentation/views/widgets/show_image_button.dart';

class PlaceDetailsViewBody extends StatefulWidget {
  const PlaceDetailsViewBody({super.key, required this.tourModel});
  final TourModel tourModel;
  @override
  PlaceDetailsViewBodyState createState() => PlaceDetailsViewBodyState();
}

class PlaceDetailsViewBodyState extends State<PlaceDetailsViewBody>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _hotelController = TextEditingController();

  DateTime? selectedDate;
  int adults = 1;
  int children = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isBookingInProgress = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _hotelController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      _showErrorMessage('Please select a departure date');
      return;
    }

    setState(() {
      _isBookingInProgress = true;
    });

    final bookingData = {
      'full_name': _fullNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone_number': _phoneController.text.trim(),
      'num_adults': adults,
      'num_children': children,
      'hotel': _hotelController.text.trim(),
      'departure_date': selectedDate!.toIso8601String().split('T')[0],
      'tour_id': widget.tourModel.id,
    };
    context.read<BookingCubit>().bookTour(bookingData);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[600],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      title: "Success",
      desc: message,
      dialogType: DialogType.success,
      btnOkOnPress: () {},
    ).show();
  }

  void _resetForm() {
    _fullNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _hotelController.clear();
    setState(() {
      selectedDate = null;
      adults = 1;
      children = 0;
    });
  }

  void _showImages(BuildContext context) {
    int _currentPage = 0;
    PageController _pageController = PageController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final width =
                  isDesktop ? constraints.maxWidth / 2 : constraints.maxWidth;

              return StatefulBuilder(
                builder: (context, setState) {
                  void _nextImage() {
                    if (_currentPage < widget.tourModel.images.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  }

                  void _previousImage() {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  }

                  return SizedBox(
                    width: width,
                    height: isDesktop ? 400 : constraints.maxHeight * 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close, size: 30),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: widget.tourModel.images.length,
                                onPageChanged: (index) {
                                  setState(() => _currentPage = index);
                                },
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      widget.tourModel.images[index].image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),

                              // Previous button
                              if (_currentPage > 0)
                                Positioned(
                                  left: 10,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: _previousImage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // Next button
                              if (_currentPage <
                                  widget.tourModel.images.length - 1)
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: _nextImage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // Image counter
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${_currentPage + 1} / ${widget.tourModel.images.length}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Page indicators
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.tourModel.images.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: _currentPage == index ? 12 : 8,
                                  height: _currentPage == index ? 12 : 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        _currentPage == index
                                            ? Colors.blue
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          setState(() {
            _isBookingInProgress = false;
          });

          if (state is BookingSuccess) {
            _showSuccessMessage(
              'Booking successful! We will contact you soon.',
            );
            _resetForm();
          } else if (state is BookingFailure) {
            _showErrorMessage('Booking failed: ${state.error}');
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 900;
            final isDesktop = constraints.maxWidth >= 900;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeroSection(
                        isMobile,
                        isTablet,
                        isDesktop,
                        widget.tourModel.numberOfPeople.toString(),
                        widget.tourModel.timeOfTour.toString(),
                        widget.tourModel.images[0].image,
                      ),
                      _buildMainContent(
                        isMobile,
                        isTablet,
                        isDesktop,
                        (widget.tourModel.priceAdult -
                                widget.tourModel.discount)
                            .toString(),
                      ),

                      SizedBox(height: 20),
                      AutoSizeText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Similar and Most Popular Tours",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomBestSallerTourGridView(),
                      ),
                    ],
                  ),
                ),
                // Loading overlay
                if (_isBookingInProgress)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    String numberOfPeople,
    String timeTour,
    String imageUrl,
  ) {
    final double height =
        isMobile
            ? 300.0
            : isTablet
            ? 400.0
            : 600.0;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _showImages(context);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
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
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHeroStat("4.5", 'Rating', Icons.star),
                        _buildHeroStat(timeTour, 'Duration', Icons.access_time),
                        _buildHeroStat(
                          numberOfPeople,
                          'Max Group',
                          Icons.group,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 40,
            child: GestureDetector(
              onTap: () => _showImages(context),
              child: HoverableShowImagesButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String value, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan[300], size: 16),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[300], fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainContent(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    String price,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.white],
        ),
      ),
      child:
          isDesktop
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildTourDetails()),
                  const SizedBox(width: 40),
                  Expanded(flex: 1, child: _buildTourBookingForm(price)),
                ],
              )
              : Column(
                children: [
                  _buildTourDetails(),
                  SizedBox(height: isMobile ? 20 : 30),
                  _buildTourBookingForm(price),
                ],
              ),
    );
  }

  String extractYoutubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
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
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 900;
            final videoHeight =
                isMobile
                    ? 200.0
                    : isTablet
                    ? 300.0
                    : 400.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTourHeader(
                  widget.tourModel.title,
                  widget.tourModel.timeOfTour.toString(),
                  widget.tourModel.ageRequirement.toString(),
                  widget.tourModel.availability,
                  widget.tourModel.numberOfPeople.toString(),
                ),
                const SizedBox(height: 20),
                _buildTourDescription(widget.tourModel.description),
                const SizedBox(height: 20),
                _buildTourInfo(
                  widget.tourModel.departureTime,
                  widget.tourModel.returnTime,
                ),
                const SizedBox(height: 20),
                _buildIncludedSection(),
                const SizedBox(height: 20),
                // Add YouTube Video Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: videoHeight,
                        maxWidth: constraints.maxWidth,
                      ),
                      child:
                          widget.tourModel.youtubeVideoUrl != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: videoHeight,
                                    maxWidth: constraints.maxWidth,
                                  ),
                                  child: YoutubeVideoWidget(
                                    videoId: extractYoutubeVideoId(
                                      widget.tourModel.youtubeVideoUrl!,
                                    ),
                                  ), // Use dynamic videoId if available in TourModel
                                ),
                              )
                              : SizedBox(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTourHeader(
    String tourName,
    String timeHour,
    String tourAge,
    String availability,
    String maxGroup,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                tourName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.cyan[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[100]!, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.access_time, timeHour, 'Duration'),
              _buildStatItem(Icons.groups, '$tourAge+', 'Minimum Age'),
              _buildStatItem(Icons.calendar_month, "All Year", 'Available'),
              _buildStatItem(Icons.people, maxGroup, 'Group Size'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.cyan[500]!],
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
            fontSize: 12,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
      ],
    );
  }

  Widget _buildTourDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff1a73e8), width: 1.5),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: ExpandedTile(
              title: Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFF1a73e8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              controller: ExpandedTileController(),
              leading: Icon(
                Icons.description,
                size: 24,
                color: Color(0xFF1a73e8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? formatHourAndMinute(String? timeString) {
    if (timeString == null) return null;

    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(timeString);

      return DateFormat.jm().format(parsedTime);
    } catch (e) {
      return timeString;
    }
  }

  Widget _buildTourInfo(String? departureTime, String? returnTime) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.blue[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          _buildInfoRow(
            'Departure Time',
            departureTime != null
                ? 'Around ${formatHourAndMinute(departureTime)} '
                : 'The trip will be determined with the tourist.',
            Icons.schedule,
          ),
          const SizedBox(height: 15),
          _buildInfoRow(
            'Return Time',
            returnTime != null
                ? 'Around ${formatHourAndMinute(returnTime)}'
                : 'The trip will be determined with the tourist.',
            Icons.schedule_send,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.cyan[500]!],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final includeList =
            widget.tourModel.includes.isNotEmpty
                ? widget.tourModel.includes
                    .map((item) => item.serviceName)
                    .toList()
                : ['No items listed'];

        final notIncludeList =
            widget.tourModel.notIncludes.isNotEmpty
                ? widget.tourModel.notIncludes
                    .map((item) => item.serviceName)
                    .toList()
                : ['No items listed'];
        return isMobile
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildIncludedCard(
                  'Included',
                  includeList,
                  Colors.green,
                  Icons.check_circle,
                ),
                const SizedBox(height: 15),
                _buildIncludedCard(
                  'Not Included',
                  notIncludeList,
                  Colors.red,
                  Icons.cancel,
                ),
              ],
            )
            : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildIncludedCard(
                    'Included',
                    includeList,
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildIncludedCard(
                    'Not Included',
                    notIncludeList,
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            );
      },
    );
  }

  Widget _buildIncludedCard(
    String title,
    List<String> items,
    MaterialColor color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color[200]!, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color[600], size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        title == 'Included' ? Icons.check : Icons.close,
                        color: color[600],
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: color[700],
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTourBookingForm(String price) {
    return SlideTransition(
      position: _slideAnimation,
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "$price £ ",
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
                hintText: 'John Doe',
                icon: Icons.person,
                label: "Full Name",
                controller: _fullNameController,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hintText: 'john@example.com',
                icon: Icons.email,
                label: "Email Address",
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hintText: '+201068561700',
                icon: Icons.phone,
                label: "WhatsApp Number",
                controller: _phoneController,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hintText: 'Hilton Waterfront',
                icon: Icons.hotel,
                label: "Hotel Name",
                controller: _hotelController,
              ),
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
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1a73e8), Color(0xFF1a73e8)],
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
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          '£ ${(adults * (widget.tourModel.priceAdult - widget.tourModel.discount) + children * widget.tourModel.priceChild).toString()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "£",
                      style: TextStyle(color: Colors.white, fontSize: 22),
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
                    backgroundColor: Color(0xfffedc07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.orange.withOpacity(0.4),
                    elevation: 6,
                  ),
                  onPressed: _isBookingInProgress ? null : _submitBooking,
                  child:
                      _isBookingInProgress
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.rocket_launch,
                                color: Colors.white,
                              ),
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
        const SizedBox(height: 6),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue[600], size: 16),
                const SizedBox(width: 10),
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select a date',
                  style: TextStyle(
                    color:
                        selectedDate != null ? Colors.black : Colors.grey[600],
                    fontSize: 14,
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
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              Icon(Icons.group, color: Colors.blue[600], size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
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
}
