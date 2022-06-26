import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/modules/shop_app/login/cubit/cubit.dart';
import 'package:news_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:news_flutter/modules/shop_app/register/shop_register_screen.dart';
import 'package:news_flutter/modules/shop_app/shop_layout.dart';
import 'package:news_flutter/network/local/cache_helper.dart';

import '../../../constants/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  bool _validate = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginsSuccessState) {
            if (state.loginModel!.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {
                token = state.loginModel!.data!.token;
                navigateAndFinish(
                  context,
                  ShopLayOut(),
                );
                showToast(
                    text: state.loginModel!.message,
                    state: ToastStates.success);
              });
            } else {
              showToast(
                  text: state.loginModel!.message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.red),
                      ),
                      Text(
                        'Login now to browse our hot deals',
                        style:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        errorText: _validate
                            ? 'Please Enter Your Email Address'
                            : null,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Email Address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        errorText:
                            _validate ? 'Please Enter Your password' : null,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePassVisibility();
                        },
                        controller: passwordController,
                        isPass: ShopLoginCubit.get(context).isPassShown,
                        type: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your password';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: ShopLoginCubit.get(context).suffix,
                        onSubmit: (value) {
                          emailController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          passwordController.text.isEmpty
                              ? _validate = true
                              : _validate = false;

                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: state is! ShopLoginLoadingState
                            ? defaultButton(
                                onPressed: () {
                                  emailController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                  passwordController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;

                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',
                              )
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account?',
                          ),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(
                                context,
                                ShopRegisterScreen(),
                              );
                            },
                            child: Text(
                              'Register Here',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
