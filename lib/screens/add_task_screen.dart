import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM ddd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });

      _dateController.text = _dateFormatter.format(_date);
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title • $_date • $_priority');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "Title",
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter task title'
                              : null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          onTap: _handleDatePicker,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "Date",
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _priorities
                              .map(
                                (priority) => DropdownMenuItem(
                                  value: priority,
                                  child: Text(
                                    priority,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "Priority",
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => _priority == null
                              ? 'Please select a priority level'
                              : null,
                          onChanged: (value) =>
                              setState(() => _priority = value),
                          value: _priority,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FlatButton(
                          onPressed: _submit,
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
