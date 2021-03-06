import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/domain/gender.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/screen/registration/registration_wm.dart';

class RegistrationScreen extends CoreMwwmWidget {
  const RegistrationScreen(WidgetModelBuilder wmBuilder)
      : super(widgetModelBuilder: wmBuilder);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends WidgetState<RegistrationWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.appTitle,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: wm.name.controller,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: AppString.regNameHint,
                            helperText: AppString.regNameHelper,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: wm.email.controller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: AppString.regEmailHint,
                            helperText: AppString.regEmailHelper,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: wm.age.controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: AppString.regAgeHint,
                            helperText: AppString.regAgeHelper,
                          ),
                        ),
                        const SizedBox(height: 16),
                        StreamedStateBuilder<Gender>(
                          streamedState: wm.gender,
                          builder: (context, selectedGender) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const FaIcon(FontAwesomeIcons.male,
                                        color: Colors.white54),
                                    Radio(
                                      value: Gender.male,
                                      groupValue: selectedGender,
                                      onChanged: (Gender val) {
                                        FocusScope.of(context).unfocus();
                                        wm.setGender(val);
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    const FaIcon(FontAwesomeIcons.female,
                                        color: Colors.white54),
                                    Radio(
                                      value: Gender.female,
                                      groupValue: selectedGender,
                                      onChanged: (Gender val) {
                                        FocusScope.of(context).unfocus();
                                        wm.setGender(val);
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                  color: FocusScope.of(context).isFirstFocus
                                      ? Colors.white38
                                      : Theme.of(context).accentColor,
                                ),
                                Text(
                                  AppString.regGenderHelper,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(color: Colors.white54),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: wm.skip,
                    child: const Text(AppString.regSkip),
                  ),
                  ElevatedButton(
                    onPressed: wm.submit,
                    child: const Text(AppString.regSubmit),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
