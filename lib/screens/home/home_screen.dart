import 'package:flutter/material.dart';

// ============================================================
// হোম স্ক্রিন (Home Screen Component)
// অ্যাপের মূল ড্যাশবোর্ড স্ক্রিন যেখানে ইউজার গ্রিটিং, কার্ড এবং ফিচার দেখতে পাবে।
// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ব্যাকগ্রাউন্ড কালার হালকা অফ-হোয়াইট রাখা হয়েছে ডিজাইনের সাথে মেলাতে
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------------
              // ১. হেডার সেকশন (Welcome Bhargav 👋 & Search Icon)
              // ------------------------------------------------------
              _buildHeader(),

              const SizedBox(height: 20),

              // ------------------------------------------------------
              // ২. অ্যাকশন কার্ড সেকশন (Clinic Visit & Home Visit)
              // ------------------------------------------------------
              _buildActionCards(),

              const SizedBox(height: 24),

              // ------------------------------------------------------
              // ৩. Amazing Features সেকশন টাইটেল
              // ------------------------------------------------------
              const Text(
                'Amazing Features',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E1E),
                ),
              ),

              const SizedBox(height: 14),

              // ------------------------------------------------------
              // ৪. হরাইজন্টাল ফিচার চিপস (Book Appointment, Medical Records...)
              // ------------------------------------------------------
              _buildFeatureChips(),

              const SizedBox(height: 24),

              // ------------------------------------------------------
              // ৫. Letest News সেকশন টাইটেল
              // ------------------------------------------------------
              const Text(
                'Letest News',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E1E),
                ),
              ),

              const SizedBox(height: 14),

              // ------------------------------------------------------
              // ৬. নিউজ গ্রিড (Dental, Fever, Stomach, Pregnancy)
              // ------------------------------------------------------
              _buildLatestNewsGrid(),

              // নিচ থেকে অতিরিক্ত স্পেস যাতে বটম নেভিগেশন বার কন্টেন্ট ঢেকে না ফেলে
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ১. হেডার উইজেট (Header Component)
  // ওয়েলকাম মেসেজ ও সার্চ আইকন প্রদর্শনের জন্য।
  // ============================================================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ওয়েলকাম মেসেজ ও ইমোজি
        const Text(
          'Welcome Bhargav 👋',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),

        // সার্চ আইকন বাটন
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: const Icon(
              Icons.search_rounded,
              size: 24,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ২. অ্যাকশন কার্ড সেকশন (Action Cards Component)
  // "Clinic Visit" এবং "Home Visit" দুটি কার্ড পাশাপাশি দেখানোর জন্য।
  // ============================================================
  Widget _buildActionCards() {
    return Row(
      children: [
        // --------------------------------------------------------
        // বাম পাশের কার্ড: Clinic Visit (টিয়াল ব্যাকগ্রাউন্ড)
        // --------------------------------------------------------
        Expanded(
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF009698), // টিয়াল কালার
              borderRadius: BorderRadius.circular(
                16,
              ), // কার্ডের কোণা গোল করার জন্য
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF009698).withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // প্লাস (+) আইকন সহ বৃত্তাকার ছোট কন্টেইনার
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: Color(0xFF009698),
                      size: 24,
                    ),
                  ),
                ),

                // কার্ডের টাইটেল ও সাবটাইটেল
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clinic Visit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Make an appointment',
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 14),

        // --------------------------------------------------------
        // ডান পাশের কার্ড: Home Visit (হালকা অফ-হোয়াইট ব্যাকগ্রাউন্ড)
        // --------------------------------------------------------
        Expanded(
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F7), // হালকা ধূসর ব্যাকগ্রাউন্ড
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8E9ED), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // হোম আইকন সহ বৃত্তাকার ছোট কন্টেইনার
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBECEF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.home_rounded,
                      color: Color(0xFF009698),
                      size: 22,
                    ),
                  ),
                ),

                // কার্ডের টাইটেল ও সাবটাইটেল
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Home Visit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Call the doctor home',
                      style: TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ৩. ফিচার চিপস উইজেট (Feature Chips Component)
  // ডানে-বামে স্ক্রোল করা যায় এমন বাটনের তালিকা।
  // ============================================================
  Widget _buildFeatureChips() {
    final List<String> features = [
      'Book Appointment',
      'Medical Records',
      'Find a Doctor',
      'Emergency',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: features.map((feature) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFECECEC), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C2C2E),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // ৪. লেটেস্ট নিউজ গ্রিড উইজেট (Latest News Grid Component)
  // ৪টি ছবি সহ নিউজ কার্ড গ্রিড ভিউ (Dental, Fever, Stomach, Pregnancy)।
  // ============================================================
  Widget _buildLatestNewsGrid() {
    final List<Map<String, String>> newsItems = [
      {'title': 'Dental', 'image': 'assets/images/dental.png'},
      {'title': 'Fever', 'image': 'assets/images/fever.png'},
      {'title': 'Stomach', 'image': 'assets/images/stomach.png'},
      {'title': 'Pregnancy', 'image': 'assets/images/pregnancy.png'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // প্রতি সারিতে ২টি করে কার্ড
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.05, // কার্ডের দৈঘ্য-প্রস্থের অনুপাত
      ),
      itemBuilder: (context, index) {
        final item = newsItems[index];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // কার্ডের ব্যাকগ্রাউন্ড ছবি
                Image.asset(item['image']!, fit: BoxFit.cover),

                // টেক্সট যাতে স্পষ্ট দেখা যায় তাই হালকা ওভারলে
                Container(color: Colors.black.withValues(alpha: 0.05)),

                // নিউজ কার্ডের মাঝখানে টাইটেল টেক্সট
                Center(
                  child: Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [Shadow(color: Colors.white, blurRadius: 8)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
