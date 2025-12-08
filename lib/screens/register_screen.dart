import 'package:ForLetMarketplaceNG/models/dtos/register_request_dto.dart';
import 'package:ForLetMarketplaceNG/provider/form_validator_provider.dart';
import 'package:ForLetMarketplaceNG/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../models/dtos/lgas_get_dto.dart';
import '../models/dtos/states_get_dto.dart';
import '../provider/home_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // screen variables
  StateGetDto? selectedState;
  LgasGetDto? selectedLga;
  RegisterRequestDto dto = RegisterRequestDto();
  dynamic result;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeProvider>(context, listen: false).loadStateList());
  }

  @override
  Widget build(BuildContext context) {
    // get the UI provider
    final validationProvider = context.watch<FormValidatorProvider>();
    final provider = Provider.of<HomeProvider>(context);
    final states = provider.stateList ?? [];
    final lgas = provider.lgaList ?? [];

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController houseNumberController = TextEditingController();
    TextEditingController streetNameController = TextEditingController();
    TextEditingController areaNameController = TextEditingController();
    TextEditingController stateIdController = TextEditingController();
    TextEditingController lgaIdController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Container(
            padding: screenPadding,
            decoration: background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add_outlined,
                        size: 40.sp,
                      ),
                      Text(
                        'Register on ForLet',
                        style: AppTextStyles.heading20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Full Name',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: validationProvider.validateFirstName,
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: "Your first name",
                    errorText: validationProvider.firstNameError,
                    errorStyle: errorTextStyle,
                    hintText: 'First Name',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: validationProvider.validateLastName,
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: "Your last name",
                    errorText: validationProvider.lastNameError,
                    errorStyle: errorTextStyle,
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Gender',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                    value: 'Male',
                    isExpanded: true,
                    hint: Text(
                      'Select a Gender',
                      style: TextStyle(color: greyShade3, fontSize: 16),
                    ),
                    items: [
                      'Male',
                      'Female',
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      dto.gender = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: border,
                      prefixIcon: Icon(Icons.person),
                      labelText: "Your gender",
                      errorText: validationProvider.genderError,
                      errorStyle: errorTextStyle,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Address',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: houseNumberController,
                  onChanged: validationProvider.validateHouseNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Your house number',
                    errorText: validationProvider.houseNumberError,
                    errorStyle: errorTextStyle,
                    hintText: 'House Number (e.g. 3)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: streetNameController,
                  onChanged: validationProvider.validateStreetName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Your street name',
                    errorText: validationProvider.streetNameError,
                    errorStyle: errorTextStyle,
                    hintText: 'Street Name (e.g. Bode Thomas Street)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: areaNameController,
                  onChanged: validationProvider.validateAreaName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Your area name',
                    errorText: validationProvider.areaNameError,
                    errorStyle: errorTextStyle,
                    hintText: 'Area Name (e.g. Aguda Surulere)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  child: DropdownButtonFormField<StateGetDto>(
                    value: selectedState,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(8.0),
                    hint: Text(
                      'Select a State',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                    items: states
                        .map(
                          (state) => DropdownMenuItem<StateGetDto>(
                            value: state,
                            child: Text(state.stateName),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      enabledBorder: border,
                      prefixIcon: Icon(Icons.location_on_outlined),
                      labelText: "Your state of residence",
                      errorText: validationProvider.stateIdError,
                      errorStyle: errorTextStyle,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        validationProvider.validateStateId;
                        selectedState = value;
                        dto.stateId = value?.id ?? 1;
                        Provider.of<HomeProvider>(context, listen: false)
                            .loadLgaList(value?.id ?? 1);
                        // update the provider state name and id value
                        provider.setStateLocation(selectedState!);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  child: DropdownButtonFormField<LgasGetDto>(
                    value: selectedLga,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(8.0),
                    hint: Text(
                      'Select an L.G.A',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                    items: lgas
                        .map(
                          (lga) => DropdownMenuItem<LgasGetDto>(
                            value: lga,
                            child: Text(lga.lgaName),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      enabledBorder: border,
                      prefixIcon: Icon(Icons.location_on_outlined),
                      labelText: "Your L.G.A of residence",
                      errorText: validationProvider.lgaIdError,
                      errorStyle: errorTextStyle,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      validationProvider.validateLgaId;
                      setState(() {
                        selectedLga = value;
                        dto.lgaId = value?.id ?? 1;
                        // update the provider lga name value
                        provider.setLgaLocation(selectedLga!);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Others',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: emailController,
                  onChanged: validationProvider.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Your email address',
                    errorText: validationProvider.emailError,
                    errorStyle: errorTextStyle,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: phoneController,
                  onChanged: validationProvider.validatePhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Your phone number',
                    errorText: validationProvider.phoneNumberError,
                    errorStyle: errorTextStyle,
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  controller: passwordController,
                  onChanged: validationProvider.validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Your password',
                    errorText: validationProvider.passwordError,
                    errorStyle: errorTextStyle,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: confirmPasswordController,
                  onChanged: validationProvider.validateConfirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Your password confirmation',
                    errorText: validationProvider.confirmPasswordError,
                    errorStyle: errorTextStyle,
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.password),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      result = provider.registerUser(dto);

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success'),
                          content: Text(result),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoise,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
