import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late List<String> cities;
  late String selectedCity;
  final _formKey = GlobalKey<FormState>();

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    cities = ['Makassar', 'Tulungagung', 'Banyumas'];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            'Daftar',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget imageLogin() {
      return Container(
        width: 310,
        height: 210,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image_register.png'),
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          controller: nameController,
          title: 'Nama Lengkap',
          hintText: 'Nama lengkapmu',
          keyboardType: TextInputType.text,
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          controller: emailController,
          title: 'Email',
          hintText: 'Email',
          obsecureText: false,
          keyboardType: TextInputType.emailAddress,
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          controller: passwordController,
          title: 'Password',
          hintText: 'Password',
          obsecureText: true,
          keyboardType: TextInputType.text,
        );
      }

      Widget cityInput() {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "City",
                  style: TextStyle(color: kBlackColor),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: selectedCity,
                    items: cities
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) {
                      setState(() {
                        selectedCity = item as String;
                      });
                    }),
              ),
            ],
          ),
        );
      }

      Widget submitButton() {
        return CustomButton(
          textStyle: GoogleFonts.poppins(color: kWhiteColor),
          title: 'Daftar',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (nameController.text.length < 3) {
                displayToastMessage(
                    "name must me atleast 3 characters", context);
              } else if (!emailController.text.contains("@")) {
                displayToastMessage("Email address is not Valid", context);
              } else if (passwordController.text.length < 6) {
                displayToastMessage(
                    "Password must be atleast 6 characters", context);
              } else {
                User user = User(
                    name: nameController.text,
                    email: emailController.text,
                    city: selectedCity);

                setState(() {
                  isLoading = true;
                });

                await context
                    .read<UserCubit>()
                    .registrasi(user, passwordController.text);

                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  var userState =
                      (context.read<UserCubit>().state as UserLoaded).user;
                  context.read<WisataCubit>().getWisata(userState);
                  context.read<BookmarkCubit>().getBookmarks(userState);
                  Navigator.pushNamed(context, '/main');
                } else {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                      message: (state as UserLoadingFailed).message,
                    ),
                  );
                  setState(() {
                    isLoading = false;
                  });
                }
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
              nameInput(),
              emailInput(),
              passwordInput(),
              cityInput(),
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
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
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
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Masuk',
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
