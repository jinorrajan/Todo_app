import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/presentation/views/home_screen.dart';
import 'package:todo/src/utlis/constant/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//Taking Mediaquery Sizes
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: ConstColors.mainColor,
      body: Column(
        children: [

          // Pages 
          Expanded(
            child: PageView.builder(
              itemCount: onboarddata.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnboardContent(
                height: onboarddata[index].height,
                title: onboarddata[index].title,
                text: onboarddata[index].text,
                image: onboarddata[index].image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: InkWell(
              onTap: () async {
                 final pres = await SharedPreferences.getInstance();
                
                //Checking
                if(_currentPage < onboarddata.length-1){
                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                }else{
                   pres.setBool("onboardingScren", true);
                  Get.offAll(HomeScreen());
                }
              },
              child: Container(
                height: height * 0.08,
                width: height * 0.08,
                decoration: BoxDecoration(
                    color: ConstColors.mainColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 3, color: Colors.white)),
                child: Icon(
                  _currentPage == onboarddata.length -1 ? Icons.check:
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//onboard data creation
class Onboard {
  final String image, title, text;
  final double height;

  Onboard(
      {required this.height,
      required this.image,
      required this.text,
      required this.title});
}

final List<Onboard> onboarddata = [
  Onboard(
    height: 60,
    image: 'assets/images/onboardingScreen1.png',
    text: "-Lailah Gifty Akita",
    title: "The time is now.\nwhat you have to do,  do it now.",
  ),
  Onboard(
    height: 60,
    image: 'assets/images/onboardingScreen2.png',
    text: "-Oprah Winfrey",
    title: "You can have it all.\nJust not all at once.",
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.height,
    required this.image,
    required this.title,
    required this.text,
  });

  final double height;
  final String image, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: height, vertical: height),
          child: Image.asset(image),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 15),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 55, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }
}
