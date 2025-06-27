import 'package:flutter/material.dart';
import 'package:tourist_website/core/models/images_model.dart';
import 'package:tourist_website/features/home/presentation/widgets/cursor_slider.dart';
import 'package:tourist_website/features/home/presentation/widgets/footer_section.dart';
import 'package:tourist_website/features/home/presentation/widgets/most_popular_grid_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/svg_icon.dart';
import 'package:tourist_website/features/home/presentation/widgets/type_tour_card.dart';
import 'package:tourist_website/features/home/presentation/widgets/wow_booking_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = 'home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _footerKey = GlobalKey();

  final List<Map<String, String>> tours = [
    {
      'category': 'Sea Tours',
      'title': 'Discover the Red Sea',
      'description':
          'Explore vibrant coral reefs and marine life with our guided snorkeling and diving tours.',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_fF8TxZhndSU0lrifE1JsUPgcCDycsfKpgoDw0iGlb_bOF_x8p6Ihq75tYQmWgh2OZHIt7TwI5NGWxAE551_nX_WcwWhTERPszin504Fh1Up5CMLDqw6p8uW8s4lW2cPRWcydi3kXtArbPvmV4e74cAwU081nfxQVNtx3dqeDlUtlhxeo3qRt7lWg4ejjvsH2_UFnFEIk3r8Wa6HRtNRx6_YQSqMpSmpN9NRMm2YoY1z42_b9ZW-zCewsLX-iGHSRJwAK8DxXKfI',
    },
    {
      'category': 'Desert Safari',
      'title': 'Adventure in the Sinai Desert',
      'description':
          'Experience the thrill of a desert safari with quad biking, camel rides, and traditional Bedouin dinners.',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAtkZOt4GJawpKfbwL-0VbFQfHgptkGrRqkLK_UljHfcUXA-WSazHMbJSNx7K1awCtya-kDonuTIeqx257-RPf0jsxSJWJ5fyNVAmdVZXw5e_7PBkxr36biaPRTv7HxNZ0rtoq3U6WvEkSU_vgVOImhijvkBldZ2o_xkvzi2YUq2TQgGtLNHV9g-H8DbEkU3GmhVpF_sbnIZmlnICW18jx-L6V4AufRfrB3zmpuQLOO64_QoUvflse4KsBikQAN3kW1E4xckSom_Ew',
    },
    {
      'category': 'Historical Places',
      'title': 'Journey Through History',
      'description':
          'Visit ancient sites and learn about the rich history of the region with our expert-led tours.',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAtkZOt4GJawpKfbwL-0VbFQfHgptkGrRqkLK_UljHfcUXA-WSazHMbJSNx7K1awCtya-kDonuTIeqx257-RPf0jsxSJWJ5fyNVAmdVZXw5e_7PBkxr36biaPRTv7HxNZ0rtoq3U6WvEkSU_vgVOImhijvkBldZ2o_xkvzi2YUq2TQgGtLNHV9g-H8DbEkU3GmhVpF_sbnIZmlnICW18jx-L6V4AufRfrB3zmpuQLOO64_QoUvflse4KsBikQAN3kW1E4xckSom_Ew',
    },
    {
      'category': 'Adventure',
      'title': 'Thrilling Activities',
      'description':
          'Get your adrenaline pumping with activities like rock climbing, canyoning, and more.',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCMACXxkUldyAw8tluI6tgku3G7C8cu4aZ7eP2CDWTnyQeOSxz-7jef7-aUxhfcqZdIBEmBGRtEhb8p9xPeteaXRmncSV1faA-g9LAqApAh3pSckcice611ulbsdi1s58hyYTiztNaTXpo-vd4JzfoPtTnriIbot0NsGkAfoQ-GVkIrlzKlsc8BpuvSaPk6aXdbi4ZoD1FZ1wUnCzOwhIJk8swnrGjy6i2bXTQvo_cmBTb5DyG2xQ9tbXs14ET9yEQjndxHnquHZ7w',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll to FooterSection
  void _scrollToFooter() {
    Scrollable.ensureVisible(
      _footerKey.currentContext!,
      alignment: 0.0, 
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SvgIcon(),
        ),
        title: const Text(
          'Sharm El-Sheikh',
          style: TextStyle(
            color: Color(0xFF101518),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFFEAEDF1),
            height: 1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _scrollToFooter,
            child: const Text(
              "About Us",
              style: TextStyle(fontSize: 20, color: Color(0xFF101518)),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
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
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Column(
                            
                            children: [
                              const Text(
                                'Sharm El Sheikh Excursions & Tours & Best Things To Do',
                                style: TextStyle(
                                  color: Color(0xFF101518),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  // letterSpacing: -0.33,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Explore Sharm el Sheikh and Egypt with Vova Tours. We are here to present you with a wide variety of excursions to and from sharm el sheikh, such as overday trips to Cairo, Luxor, Alexandria, Jerusalem, petra, quad biking, Dolphin show, Swimming with the dolphins",
                                style: TextStyle(
                                  color: Color(0xFF8D9199),
                                  fontSize: 15 ,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tours.length,
                                itemBuilder: (context, index) {
                                  final tour = tours[index];
                                  return TourCard(
                                    category: tour['category']!,
                                    title: tour['title']!,
                                    description: tour['description']!,
                                    imageUrl: tour['imageUrl']!,
                                  );
                                },
                              ),
                              
                             
                             SizedBox(height: 20,),
                             Text("Most popular Trips" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.w600),) ,
                             SizedBox(height: 8,),
                             Text("Discover our most popular excursions" , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w500 , color: Color(0xFF8D9199)),) ,
                             SizedBox(height: 12,),
                             CustomMostPopularGridView(),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  HowBookingSection() ,
                  const SizedBox(height: 20),
                  KeyedSubtree(
                  key: _footerKey,
                  child: const FooterSection(),
                ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
