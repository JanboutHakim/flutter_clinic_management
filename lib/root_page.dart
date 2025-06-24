import 'package:doclib/core/navigation/pagesbloc/bloc/pages_bloc.dart';
import 'package:doclib/features/appointments/presentation/pages/appointments_page.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/auth/presentation/pages/account.dart';
import 'package:doclib/features/auth/presentation/pages/patient_signup_page.dart';
import 'package:doclib/features/drugs/presentation/pages/drugs_pages.dart';
import 'package:doclib/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext cvontext) {
    return BlocProvider(
      create: (context) => PagesBloc(),
      child: BlocBuilder<PagesBloc, PagesState>(
        builder: (cvontext, pagesState) {
          return Scaffold(
            body: IndexedStack(
              index: pagesState.index,
              children: [
                HomePage(),
                AppointmentsPage(),
                DrugsPages(),
                testwid(text: "four"),
                AccountRootPage(),
              ],
            ),

            appBar: AppBar(
              title: Text(pagesState.title),
              backgroundColor: Colors.green.shade300,
              // clipBehavior: Clip.antiAlias,
              actions: [
                BlocBuilder<AuthBlocBloc, AuthBlocState>(
                  builder: (context, state) {
                    return state is AuthAuthenticated
                        ? const Text("login")
                        : const Text("notlogin");
                  },
                ),
              ],
            ),
            // body: context.read(),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              // backgroundColor: Colors.black,
              currentIndex: pagesState.index,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.green,
                  icon: Icon(Icons.home),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.green,

                  icon: Icon(Icons.date_range),
                  label: "appointment",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.health_and_safety_rounded),
                  label: "drugs",
                ),
                // BottomNavigationBarItem(icon: Icon(Icons.abc), label: "drugs"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner),
                  label: "documents",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_accounts_sharp),
                  label: "Accont",
                ),
              ],
              onTap: (value) {
                cvontext.read<PagesBloc>().add(PageEvent(index: value));
              },
            ),
          );
        },
      ),
    );
  }
}

class testwid extends StatelessWidget {
  final String text;
  testwid({required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
