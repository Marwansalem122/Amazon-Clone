// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourism_app/common/routes/names.dart';
// import 'package:tourism_app/view/feature/welcome/pages/homescreen/homescreen.dart';
// // import 'package:tourism_app/common/routes/routes.dart';
// import 'package:tourism_app/view/feature/welcome/pages/login/bloc/signin_bloc.dart';
// import 'package:tourism_app/view/feature/welcome/pages/login/login_page.dart';
// import 'package:tourism_app/view/feature/welcome/pages/signup/signup_page.dart';

// import '../../view/feature/welcome/pages/homescreen/welcome_bloc/welcome_bloc.dart';

// class AppPage{
//   static List<PageEntity> routes(){
//  return [
      
//       PageEntity(
//           route: AppRoutes.SIGNIN,
//           page: const LoginPage(),
//           bloc: BlocProvider(create: (_) => SigninBloc())),
//       PageEntity(
//           route: AppRoutes.REGISTER,
//           page: const SignupPage(),
//           bloc: BlocProvider(create: (_) => SigninBloc())),
//       PageEntity(
//           route: AppRoutes.HOME_PAGE,
//           page: const HomeScreen(),
//           bloc: BlocProvider(create: (_) => WelcomeBloc())),
    
//     ];
 
//   }
//   static List<dynamic> allblocproviders(BuildContext context) {
//     List<BlocProvider> blocproviders = [];
//     for (var bloc in routes()) {
//       blocproviders.add(bloc.bloc);
//     }
//     return blocproviders;
//   }
  
// }

// class PageEntity {
//   String route;
//   Widget page;
//   dynamic bloc;
//   PageEntity({required this.route, required this.page, this.bloc});
// }
