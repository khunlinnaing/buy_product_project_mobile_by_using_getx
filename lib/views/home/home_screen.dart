import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for three PageViews
  final PageController _controller1 = PageController(initialPage: 1000);
  final PageController _controller2 = PageController(initialPage: 1000);
  final PageController _controller3 = PageController(initialPage: 1000);

  late Timer _timer;

  final List<String> _dryTeaImages = ['dry_1.jpeg', 'dry.png', 'dry_1.jpeg'];
  final List<String> _wetTeaImages = ['image1.png', 'wet.jpeg', 'wet.jpeg'];
  final List<String> _leaveTeaImages = [
    'tea_leaves.jpeg',
    'leaves1.jpg',
    'leaves2.jpg',
  ];

  @override
  void initState() {
    super.initState();

    // Start auto rotation
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller1.hasClients) {
        _controller1.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      if (_controller2.hasClients) {
        _controller2.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      if (_controller3.hasClients) {
        _controller3.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget _buildLoopingPageView(
    PageController controller,
    List<String> images,
    String label,
  ) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                final image = images[index % images.length];

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$image'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$label',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildLoopingPageView(_controller1, _wetTeaImages, "wet".tr),
            const SizedBox(height: 20),
            _buildLoopingPageView(_controller2, _dryTeaImages, "dry".tr),
            const SizedBox(height: 20),
            _buildLoopingPageView(_controller3, _leaveTeaImages, "leave".tr),
          ],
        ),
      ),
    );
  }
}
