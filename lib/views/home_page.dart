import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/components/form/form.dart';
import 'package:flutter_basic_setup/shared/components/form/form_fields.dart';
import 'package:flutter_basic_setup/shared/cubits/intl_cubit.dart';
import 'package:flutter_basic_setup/shared/cubits/theme_mode_cubit.dart';
import 'package:flutter_basic_setup/shared/extensions/intl_extension.dart';
import 'package:flutter_basic_setup/shared/extensions/theme_extenstion.dart';
import 'package:flutter_basic_setup/views/details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  static const String route = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter.isEven) {
        context.read<ThemeModeCubit>().setDarkMode();
      } else {
        context.read<ThemeModeCubit>().setLightMode();
      }
      var newLang =
          IntlCubit.getLocaleByCountryCode(_counter.isEven ? "pl_PL" : "en_US");
      if (newLang != null) {
        context.read<IntlCubit>().loadLanguage(newLang);
      }
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.background,
      appBar: AppBar(
        backgroundColor: context.theme.appColors.primary,
        title: Text(
          widget.title,
          style: context.theme.appTypos.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.translate("views.main"),
            ),
            Text('$_counter', style: context.theme.appTypos.title),
            TextButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(DetailsPage.route);
                },
                child: Text('Details Page')),
            AppFormBuilder(
              formKey: _formKey,
              child: (appFormState) => Column(
                children: [
                  AppTextField(
                    name: 'email',
                    label: "ASASDASD",
                    isObligatory: true,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (p0) => InputValidators.isValidEmail(p0),
                  ),
                  AppTextField(
                    name: 'emaxil',
                    validator: (p0) => InputValidators.isValidEmail(p0),
                  ),
                  AppCheckbox(
                    validator: (p0) =>
                        p0 == false ? "Pole jest obowiązkowe" : null,
                    name: "checkbox",
                    label: "iusdjfks",
                  ),
                  AppDropdown(
                      isObligatory: true,
                      initialValue: null,
                      validator: (p0) =>
                          InputValidators.isNotNull(p0?.toString()),
                      items: [
                        DropdownMenuItem(
                          child: Text("data"),
                          value: 1,
                        )
                      ],
                      name: "dropdown",
                      label: "Dropdown"),
                  AppSlider(name: "asd", initialValue: 1, min: 0, max: 50),
                  AppSwitch(
                    name: "ADS",
                    label: "Switch",
                    isObligatory: true,
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    color: appFormState.isValid
                        ? context.theme.appColors.success
                        : context.theme.appColors.error,
                    onPressed: () {},
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
