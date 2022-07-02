import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            'Masuk',
          ),
        ),
      );
    }

    Widget imageLogin() {
      return Container(
        width: double.infinity,
        height: 210,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image_login.png'),
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget emailInput() {
        return CustomTextFormField(
            controller: emailController,
            title: 'Email Address',
            hintText: 'Your email address',
            keyboardType: TextInputType.emailAddress);
      }

      Widget passwordInput() {
        return CustomTextFormField(
            controller: passwordController,
            title: 'Password',
            hintText: 'Your password',
            obsecureText: true,
            keyboardType: TextInputType.text);
      }

      Widget submitButton() {
        return CustomButton(
          textStyle: GoogleFonts.poppins(color: kWhiteColor),
          title: 'Masuk',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });

              try {
                await context
                    .read<UserCubit>()
                    .login(emailController.text, passwordController.text);
              } catch (e) {
                print(e);
              }

              UserState state = context.read<UserCubit>().state;

              if (state is UserLoaded) {
                var user = (context.read<UserCubit>().state as UserLoaded).user;
                context.read<WisataCubit>().getWisata(user);
                context.read<BookmarkCubit>().getBookmarks(user);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (Route<dynamic> route) => false);
              } else {
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Login Failed",
                  ),
                );
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              emailInput(),
              passwordInput(),
              (isLoading == true)
                  ? Center(
                      child: loadingIndicator,
                    )
                  : submitButton(),
            ],
          ),
        ),
      );
    }

    Widget tacButton() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum ada akun?',
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Daftar',
                style: yellowTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: light,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title(),
                imageLogin(),
                inputSection(),
                tacButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
