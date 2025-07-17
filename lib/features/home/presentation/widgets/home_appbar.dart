import 'package:flutter/material.dart';
import 'package:tourist_website/features/home/presentation/widgets/contact_us.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/transporation_Booking_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey footerKey;
  const CustomAppBar({super.key, required this.footerKey});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  void _scrollToFooter(BuildContext context) {
    Scrollable.ensureVisible(
      footerKey.currentContext!,
      alignment: 0.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToContactUs(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => const ContactUsScreen(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToTransportation(BuildContext context) {
    Navigator.pushNamed(context, TransporationBookingView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 850;

    return AppBar(
      toolbarHeight: 100,
      centerTitle: isMobile ? true : false,
      leading:
          isMobile
              ? IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF101518)),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
              : Container(),
      title:
          isMobile
              ? const Text(
                'Sharm El-Sheikh Excursions',
                style: TextStyle(
                  color: Color(0xFF1a73e8),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
              : Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Sharm El-Sheikh Excursions',
                    style: TextStyle(
                      color: Color(0xFF1a73e8),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
      backgroundColor: Color(0xfffedc07),
      elevation: 1,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(color: Color(0xFFEAEDF1), height: 1),
      ),
      actions:
          isMobile
              ? [Image.asset("assets/images/logo.png", width: 100, height: 100)]
              : [
                NavLink(text: 'Contact Us', onTap: () => _launchWhatsApp()),
                // NavLink(
                //   text: 'Transportation',
                //   onTap: () => _navigateToTransportation(context),
                // ),
                NavLink(
                  text: 'About Us',
                  onTap: () => _scrollToFooter(context),
                ),
                SizedBox(width: 16),
              ],
    );
  }
}

void _launchWhatsApp() async {
  final Uri whatsapp = Uri.parse("https://wa.me/+201062155477");
  if (await canLaunchUrl(whatsapp)) {
    await launchUrl(whatsapp);
  } else {
    debugPrint("Could not launch WhatsApp");
  }
}

class NavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const NavLink({required this.text, required this.onTap, super.key});

  @override
  _NavLinkState createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 240),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              widget.text,
              style: TextStyle(
                color:
                    _isHovered
                        ? Color.fromARGB(255, 142, 155, 162)
                        : Color(0xFF101518),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              semanticsLabel: widget.text,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final GlobalKey footerKey;
  const CustomDrawer({super.key, required this.footerKey});

  void _scrollToFooter(BuildContext context) {
    Navigator.pop(context);
    Scrollable.ensureVisible(
      footerKey.currentContext!,
      alignment: 0.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToContactUs(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => const ContactUsScreen(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToTransportation(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, duration) => TransporationBookingView(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF007aff), Color.fromARGB(255, 251, 255, 0)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sharm El-Sheikh Tours',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore Egypt with Vova Tours',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.email_outlined,
              title: 'Contact Us',
              onTap: () => _launchWhatsApp(),
            ),
            // _buildDrawerItem(
            //   context,
            //   icon: Icons.directions_bus_filled_outlined,
            //   title: 'Transportation',
            //   onTap: () => _navigateToTransportation(context),
            // ),
            _buildDrawerItem(
              context,
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => _scrollToFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return _DrawerItem(icon: icon, title: title, onTap: onTap);
  }
}

class _DrawerItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  __DrawerItemState createState() => __DrawerItemState();
}

class __DrawerItemState extends State<_DrawerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color:
                    _isHovered
                        ? Colors.white.withOpacity(0.3)
                        : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white, size: 28),
                  const SizedBox(width: 16),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: _isHovered ? Color(0xFF0077B6) : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    semanticsLabel: widget.title,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
