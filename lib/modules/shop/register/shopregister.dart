import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/modules/shop/register/cubit/cubit.dart';
import 'package:flutter_app1/modules/shop/register/cubit/states.dart';
import 'package:flutter_app1/shared/component/component.dart';
import 'package:flutter_app1/shared/component/conestanse.dart';
import 'package:flutter_app1/shared/network/cacheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shop_layout.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());

                showToast(
                    text: state.loginModel.message, state: ToastStates.SUCCESS);
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your name ';
                                }
                              },
                              label: 'User Name ',
                              prefix: Icons.person),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your email ';
                                }
                              },
                              label: 'Email Address ',
                              prefix: Icons.person),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.phone,
                            isPassword:
                                ShopRegisterCubit.get(context).isPasswordShown,
                            onSubmitted: (value) {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your password ';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            hint: '',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            /*
                            isPassword:
                                ShopRegisterCubit.get(context).isPasswordShown,*/
                            onSubmitted: (value) {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixPressed: () {
                              /*          ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();*/
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number ';
                              }
                            },
                            label: 'phone',
                            prefix: Icons.phone,
                            hint: '',
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: State is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'register',
                                isUpperCase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
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
