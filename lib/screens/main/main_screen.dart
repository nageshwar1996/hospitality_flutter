import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../message/message_screen.dart';
import '../get_help/get_help_screen.dart';
import '../schedule/schedule_screen.dart';
import '../profile/profile_screen.dart';

// ============================================================
// মেইন স্ক্রিন (Main Container Screen)
// এই স্ক্রিনটি বটম নেভিগেশন বার এবং ৫টি আলাদা পেজের মধ্যে সুইচ নিয়ন্ত্রণ করে।
// ============================================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // বর্তমানে সিলেক্ট হওয়া ট্যাবের ইনডেক্স (ডিফল্ট ০ = HomeScreen)
  int _currentIndex = 0;

  // অ্যাপের ৫টি মূল পেজের তালিকা
  final List<Widget> _pages = [
    const HomeScreen(),
    const MessageScreen(),
    const GetHelpScreen(),
    const ScheduleScreen(),
    const ProfileScreen(),
  ];

  // অ্যাক্টিভ ও ইন-অ্যাক্টিভ কালার থিম
  static const Color _activeColor = Color(0xFF009698); // সাইয়ান/টিয়াল কালার
  static const Color _inactiveColor = Color(0xFF9E9E9E); // ধূসর কালার

  // ============================================================
  // কাস্টম বটম নেভিগেশন বার উইজেট (Custom Bottom Navigation Builder)
  // ============================================================
  Widget _buildBottomNavigation() {
    // ডিভাইসের নিচের নচ বা জেসচার বারের নিরাপদ দূরত্ব হিসাব
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.transparent,
      // দুই পাশে ১৬ পিক্সেল মার্জিন এবং নিচে ডিভাইসের জন্য উপযুক্ত গ্যাপ
      margin: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        bottomPadding > 0 ? bottomPadding / 2 : 10,
      ),
      child: SizedBox(
        height: 64, // নেভিগেশন বারের উচু বডির সাইজ
        child: Stack(
          clipBehavior: Clip.none, // যাতে মাঝের Get Help বাটন বারের উপরে ভেসে উঠতে পারে
          children: [
            // ----------------------------------------------------
            // ১. ব্যাকগ্রাউন্ড কার্ভড শেপ এবং শ্যাডো (CustomPaint)
            // ----------------------------------------------------
            Positioned.fill(
              child: CustomPaint(
                painter: BottomNavPainter(),
              ),
            ),

            // ----------------------------------------------------
            // ২. নেভিগেশন আইটেমসমূহ (Row layout for 5 items)
            // ----------------------------------------------------
            Positioned.fill(
              child: Row(
                children: [
                  // ১ নম্বর ট্যাব: Home
                  Expanded(
                    child: _buildNavItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      index: 0,
                    ),
                  ),

                  // ২ নম্বর ট্যাব: Message
                  Expanded(
                    child: _buildNavItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Message',
                      index: 1,
                    ),
                  ),

                  // ৩ নম্বর ফাঁকা জায়গা (মাঝের Get Help বাটনের স্পেসের জন্য)
                  const Expanded(
                    child: SizedBox(),
                  ),

                  // ৪ নম্বর ট্যাব: Schedule
                  Expanded(
                    child: _buildNavItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Schedule',
                      index: 3,
                    ),
                  ),

                  // ৫ নম্বর ট্যাব: MyProfile
                  Expanded(
                    child: _buildNavItem(
                      icon: Icons.person_outline_rounded,
                      label: 'MyProfile',
                      index: 4,
                    ),
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------
            // ৩. মাঝের ভাসমান "Get Help" বাটন (Center Floating Button)
            // ----------------------------------------------------
            Positioned(
              top: -22, // নেভিগেশন বারের থেকে একটু উপরে ভাসিয়ে রাখা হয়েছে
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _currentIndex = 2; // Get Help পেজে সুইচ হবে
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // টিয়াল রঙের বৃত্তাকার বাটন (হোয়াইট বর্ডার ও শ্যাডো সহ)
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _activeColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _activeColor.withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 3),

                      // "Get Help" লেবেল
                      Text(
                        'Get Help',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 2 ? _activeColor : _inactiveColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // একক নেভিগেশন আইটেম তৈরির মেথড (Single Nav Item Builder)
  // ============================================================
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _currentIndex = index; // ক্লিক করলে সক্রিয় ট্যাবে পেজ পরিবর্তন হবে
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? _activeColor : _inactiveColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isSelected ? _activeColor : _inactiveColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true দিলে পেজের কন্টেন্ট কার্ভড নেভিগেশন বারের পেছনে সুন্দরভাবে দেখা যায়
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}

// ============================================================
// কাস্টম বটম নেভিগেশন পেইন্টার (Custom Painter for Curve & Shadow)
// সাদা ব্যাকগ্রাউন্ড শেপ, মাঝের ওপরের দিকে বাঁকানো কার্ভ এবং ড্রপ শ্যাডো তৈরির জন্য।
// ============================================================
class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    final double centerX = w / 2;

    const double cornerRadius = 24.0; // ওপরের দুই কোণার গোল ব্যাসার্ধ
    const double domeWidth = 76.0;    // মাঝের উচু কার্ভের বিস্তার
    const double domeHeight = 22.0;   // কার্ভটি কতটুকু ওপরে উঠবে

    // ১. ওপরের বাম কোণা থেকে লাইন শুরু
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // ২. বাম পাশের ফ্ল্যাট লাইন (কার্ভ শুরুর আগের অংশ)
    path.lineTo(centerX - (domeWidth / 2), 0);

    // ৩. মাঝের ভাসমান বাটনের চারপাশের গোল উচু কার্ভ (Dome Curve)
    path.cubicTo(
      centerX - (domeWidth / 4),
      0,
      centerX - (domeWidth / 4),
      -domeHeight,
      centerX,
      -domeHeight,
    );
    path.cubicTo(
      centerX + (domeWidth / 4),
      -domeHeight,
      centerX + (domeWidth / 4),
      0,
      centerX + (domeWidth / 2),
      0,
    );

    // ৪. ডান পাশের ফ্ল্যাট লাইন ও ডান কোণার কার্ভ
    path.lineTo(w - cornerRadius, 0);
    path.quadraticBezierTo(w, 0, w, cornerRadius);

    // ৫. নিচের ডান এবং বাম অংশ সংযুক্ত করা
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    // ৬. নেভিগেশন বারের সফট ড্রপ শ্যাডো আঁকা
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawPath(path.shift(const Offset(0, -2)), shadowPaint);

    // ৭. সম্পূর্ণ নেভিগেশন বারটি সাদা রঙে ফিল করা
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
