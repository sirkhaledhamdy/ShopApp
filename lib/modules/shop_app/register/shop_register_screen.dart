import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:news_flutter/modules/shop_app/register/register_cubit/states.dart';

import '../../../constants/components/components.dart';
import '../../../constants/constants.dart';
import '../../../network/local/cache_helper.dart';
import '../shop_layout.dart';

class ShopRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  bool _validate = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context, state){
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel!.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel!.data!.token,
              ).then((value) {
                token = state.registerModel!.data!.token;
                navigateAndFinish(
                  context,
                  ShopLayOut(),
                );
                showToast(
                    text: state.registerModel!.message,
                    state: ToastStates.success);
              });
            } else {
              showToast(
                  text: state.registerModel!.message, state: ToastStates.error);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Elite',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      'Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
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
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.red),
                        ),
                        Text(
                          'Register now to browse our hot deals',
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
                              ? 'Please Enter Your Full Name'
                              : null,
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Full Name';
                            }
                          },
                          label: 'Full Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 20,),
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
                            ShopRegisterCubit.get(context)
                                .changePassVisibility();
                          },
                          controller: passwordController,
                          isPass: ShopRegisterCubit.get(context).isPassShown,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffix,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          errorText: _validate
                              ? 'Please Enter Your Phone Number'
                              : null,
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: state is! ShopRegisterLoadingState
                              ? defaultButton(
                            onPressed: () {
                              emailController.text.isEmpty
                                  ? _validate = true
                                  : _validate = false;
                              passwordController.text.isEmpty
                                  ? _validate = true
                                  : _validate = false;

                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          )
                              : CircularProgressIndicator(),
                        ),
                      ],
                    ),
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
