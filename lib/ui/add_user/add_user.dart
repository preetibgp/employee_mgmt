import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:cross_file/cross_file.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/di/inject.dart';
import 'package:employee_app/main.dart';
import 'package:employee_app/ui/add_user/add_user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddUserBloc>(),
      child: const AddUserContent(),
    );
  }
}

class AddUserContent extends StatefulWidget {
  const AddUserContent({Key? key}) : super(key: key);

  @override
  State<AddUserContent> createState() => _AddUserContentState();
}

class _AddUserContentState extends State<AddUserContent> {
  late double _height;
  late double _width;

  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());

    var localizations = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {
        var result = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.alertDialogTitle),
            actions: [
              TextButton(
                child: Text(localizations.cancel),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(localizations.leave),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.addEmployeeTitle),
        ),
        body: BlocListener<AddUserBloc, AddUserState>(
          listener: (context, newState) {
            if (newState is AddUserSuccess) {
              Navigator.of(context).pop();
            } else if (newState is AddUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localizations.generalError)));
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: localizations.addEmployeeNameLabel,
                          hintText: localizations.addEmployeeNameHint,
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail),
                          labelText: localizations.addEmployeeEmailLabel,
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.emailAddress,
                      validator: EmailValidator(
                          errorText: localizations.errorEmailFormat),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'phone',
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: localizations.addEmployeePhoneLabel,
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderDropdown<UserStatus>(
                      name: 'status',
                      decoration: InputDecoration(
                          labelText: localizations.addEmployeeStatusLabel,
                          border: OutlineInputBorder()),
                      initialValue: UserStatus.employee,
                      items: [
                        DropdownMenuItem(
                            child: Text(localizations.employeeStatusManager),
                            value: UserStatus.employee),
                        // DropdownMenuItem(
                        //     child: Text(localizations.employeeStatusWorker),
                        //     value: UserStatus.employee),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Choose Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: _width / 2.5,
                                  height: _height / 14,
                                  margin: EdgeInsets.only(top: 15),
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: _dateController,
                                    onSaved: (val) {
                                      _setDate = val!;
                                    },
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // labelText: 'Time',
                                        contentPadding:
                                            EdgeInsets.only(top: 0.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Choose Time',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: _width / 2.5,
                                  height: _height / 14,
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                    onSaved: (val) {
                                      _setTime = val!;
                                    },
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: _timeController,
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // labelText: 'Time',
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Builder(builder: (context) {
                        return BlocBuilder<AddUserBloc, AddUserState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              child: Text(localizations.addEmployeeCreateLabel),
                              onPressed: state is AddUserLoading
                                  ? null
                                  : () {
                                      var form = FormBuilder.of(context)!;
                                      if (form.saveAndValidate()) {
                                        var user = UserData(
                                          Random().nextInt(1 << 31),
                                          form.value['name']!,
                                          form.value['email']!,
                                          form.value['phone']!,
                                          form.value['status']!,
                                          //  form.value['createdAt']!,
                                          'https://randomuser.me/api/portraits/men/${Random().nextInt(100)}.jpg',
                                          DateTime.now().toString(),
                                        );
                                        context
                                            .read<AddUserBloc>()
                                            .add(AddUserRegisterEvent(user));
                                      }
                                    },
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
