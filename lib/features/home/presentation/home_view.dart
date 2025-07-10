import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/images_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/home/data/repos/all_tours_repository_impl.dart';
import 'package:tourist_website/features/home/domain/usecases/get_all_tours_usecase.dart';
import 'package:tourist_website/features/home/presentation/cubit/get_best_saller_cubit.dart';
import 'package:tourist_website/features/home/presentation/lists/category_list_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/cursor_slider.dart';
import 'package:tourist_website/features/home/presentation/widgets/footer_section.dart';
import 'package:tourist_website/features/home/presentation/lists/list_tours.dart';
import 'package:tourist_website/features/home/presentation/widgets/home_appbar.dart';
import 'package:tourist_website/features/home/presentation/widgets/how_pay_section.dart';
import 'package:tourist_website/features/home/presentation/widgets/most_popular_grid_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/wow_booking_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = 'home';
  static late ScrollController globalScrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _footerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    HomePage.globalScrollController = _scrollController;
    _scrollController.addListener(
      _handleScroll,
    ); // Add scroll listener for smooth behavior
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(footerKey: _footerKey), // Use CustomAppBar
      drawer: CustomDrawer(
        footerKey: _footerKey,
      ), // Add CustomDrawer for mobile
      body: BlocProvider(
        create:
            (context) => GetAllToursCubit(
              GetAllToursUseCase(
                GetAllToursRepoImpl(apiService: ApiService(Dio())),
              ),
            )..getAllTours(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(), // Smooth with no bounce
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth > 960 ? 30 : 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomCarouselSlider(cities: lst),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth < 700 ? 0 : 30,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Sharm El Sheikh Excursions & Tours & Best Things To Do',
                                  style: TextStyle(
                                    color: Color(0xFF101518),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Explore Sharm el Sheikh and Egypt with Vova Tours. We are here to present you with a wide variety of excursions to and from sharm el sheikh, such as overday trips to Cairo, Luxor, Alexandria, Jerusalem, petra, quad biking, Dolphin show, Swimming with the dolphins",
                                  style: TextStyle(
                                    color: Color(0xFF8D9199),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomCategoryListView(tours: tours),
                                const SizedBox(height: 20),
                                const Text(
                                  "Explore All Trips",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 8),
                                const Text(
                                  "Discover our most popular excursions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF8D9199),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const CustomMostPopularGridView(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    HowBookingSection(width: constraints.maxWidth),
                    const SizedBox(height: 20),
                    HowPaySection(width: constraints.maxWidth),
                    const SizedBox(height: 20),
                    KeyedSubtree(key: _footerKey, child: const FooterSection()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
