import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';
import 'package:time_tracker_flutter/app/home/domain/repositories/database.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/platform_exception_alert_dialog.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key, @required this.database}) : super(key: key);

  final Database database;
  
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(database: database),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {

  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour; 

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: _buildFormChildren(),
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job Name'),
        validator: (value) => value.isNotEmpty ? null : "Name can't be empty",
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate Per Hour'),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      ),
    ];
  }

  Future<void> _submit() async {
    if(_validateAndSaveForm()) {
      try {
        final job = Job(name: _name, ratePerHour: _ratePerHour);
        await widget.database.createJob(job);
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          exception: e,
          title: 'Operation Failed',
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Job"),
        elevation: 2.0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed: _submit,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }
}
