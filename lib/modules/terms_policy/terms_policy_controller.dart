import 'package:crypto_app/network_services/initializer.dart';
import 'package:get/get.dart';

class TermsPolicyController extends GetxController {
  RxString type = ''.obs;
  String content = '';
  String terms = '''
Welcome to X-chain, the world's fastest growing digital system. Here we are happy to announce that we are taking steps to grow to new platforms. The first is a social media platform application which is full of new advanced AI features. We know that in this modern world, the internet is a main part of human life, and social media is an essential part of our daily lifestyle. So we are moving forward to build a better, faster, AI-based system where you will experience the amazing new atmosphere of the internet world.

The second milestone we are introducing is the E-SIM card (a number that does not require any physical card). This internet SIM card provides a unique identity for every customer, helping to confirm the right person. It is a system that gives you a real identity to connect with people. You can use it like a mobile number, which will be your real identity. It will enable voice and video calls, as well as text messaging on our platform worldwide. This new system makes it easier to find friends and new people. You can also use these E-SIM identities as your identity on our social media platforms, allowing for easy sending and receiving of payments all over the world on our upcoming exchange.

The third step will be our exchange, where you can trade. But for now, we are launching our Xchain application, where people can come and earn free X coins through daily activities, mining, and referrals. 

At the start of our system, we are providing pre-launch X coins to customers who register and complete daily tasks on the Xchain app. However, if customers want to mine more coins before launch, they can do so through our mining system by paying a fee. The fee for mining X coins will be low before our exchange launch. You will need to deposit an amount to get more X coins. 

Always remember to invest only what you can afford to lose, as there is a 0.99% chance of a negative outcome, where you could accept a loss. Additionally, we are only responsible for returning your initial deposited amount, and this return may take some time. Always consider both positive and negative possibilities. 

We believe that we are helping the digital system achieve new milestones, so be part of our rapidly growing digital community. Don't be afraid to help others, take calculated risks, and move forward, as every step could lead to new achievements. Never stop striving in the right direction.
''';


  String privacy= '''
Please read this Policy carefully to understand our policies and practices regarding your personal data and how we will treat it. By accessing or using the Services, you agree to this Policy. Our Services also incorporate privacy controls which affect how we will process your personal data. Please refer to Section 5 for a list of rights with regard to your personal data and how to exercise them.

This Policy may change from time to time. Your continued use of the Services after we make changes is deemed to be acceptance of those changes, so please check the Policy periodically for updates.
''';


  @override
  void onInit() {
    getIntentData();
    super.onInit();
  }

  void getIntentData() async {
    type.value = Get.arguments;
    type.value == 'terms' ? content = terms : content = privacy;
  }
}