import 'package:aminahub/size_config.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import '../../components/default_btn.dart';
import '../home/home_screen.dart';

class SelectLocation extends StatefulWidget {
  String address;
  SelectLocation(this.address, {super.key});

  @override
  _SelectLocationState createState() => _SelectLocationState(address);
}

class _SelectLocationState extends State<SelectLocation> {
  String address;
  _SelectLocationState(this.address);
  String selectedCity = "";
  String selectedCountry = "";
  String selectedState = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
            "Select Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/aminahub.png',
                height: 30,
            ),
            SizedBox(height: getProportionateScreenWidth(35)),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CSCPicker(
                    flagState: CountryFlag.DISABLE,
                    layout: Layout.vertical,
                    onCountryChanged: (country){
                      setState(() {
                        selectedCountry = country ?? "";
                      });
                    },
                    onStateChanged: (state){
                      setState(() {
                        selectedState = state ?? "";
                      });
                    },

                    onCityChanged: (city) {
                      setState(() {
                        selectedCity = city ?? "";
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Select and Update",
                    press: () {
                      if (selectedState != "") {
                        address = selectedState;

                        if (selectedCountry != "") {
                          address = selectedCountry + ", " + address;
                        }
                      }
                      else if (selectedCity != "") {
                        address = selectedCity;

                        if (selectedState != "") {
                          address += ", " + selectedState;
                        }
                      }else if (selectedCountry != "") {
                        address = selectedCountry;
                      }

                      Navigator.pop(context, address);
                    },
                  ),
                  SizedBox(height: 20,),
                  DefaultButton(
                    text: "Use Current Location",
                    press: () {
                      //Navigator.pushNamed(context, SignInScreen.routeName);
                      //Navigator.pushNamed(context, SignInScreen.routeName);
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
