import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/cubit/cubit.dart';
import 'package:news_flutter/cubit/states.dart';

import '../../../network/local/cache_helper.dart';
import '../on_boarding_screen.dart';

class ShopSettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  dynamic nameController = TextEditingController();
  dynamic emailController = TextEditingController();
  dynamic phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).profileModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;




        if (ShopCubit.get(context).profileModel != null) {
          return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateProfileDataState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name Can\'t Be empty';
                          }
                          return null;
                        },
                        label: 'Full Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Email Can\'t Be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Phone Can\'t Be empty';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        color: Colors.blue,
                        onPressed: () {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateProfileData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'UPDATE',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        onPressed: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            if (value == true) {
                              navigateAndFinish(context, OnBoardingScreen());
                            }
                          });
                        },
                        text: 'LOGOUT',
                      ),

                    ],
                  ),
                ),
              );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
