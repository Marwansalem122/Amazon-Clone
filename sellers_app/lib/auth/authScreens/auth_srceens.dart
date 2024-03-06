
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'package:sellers_app/screens/widgets/common_widgets.dart';
import'package:sellers_app/auth/authScreens/login_tab_page.dart';
import'package:sellers_app/auth/authScreens/registration_tab_page.dart';
class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: commonContainer(child: Container()),
          title: resuableText(
              text: "iShop",
              fontsize: 20.sp,
              letterspacing: 1,
              color: Colors.white,
              fontweight: FontWeight.bold),
          bottom: TabBar(
              labelColor: Colors.white,
              //Color of line Under login and signup
              indicatorColor: Colors.white,
              //Make the line Under login and signup take half width page
              indicatorSize: TabBarIndicatorSize.tab,
              //the weight of line Under login and signup
              indicatorWeight: 3.w,
              tabs: [
                tabLoginAndSignUp(text: "Login", icon: Icons.lock),
                tabLoginAndSignUp(text: "SignUp", icon: Icons.person),
              ]),
        ),
        body: commonContainer(
            child: const TabBarView(
          children: [LoginTabScreen(), RegistrationTabScreen()],
        )),
      ),
    );
  }
}
