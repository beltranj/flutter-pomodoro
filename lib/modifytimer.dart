import 'package:flutter/material.dart';

enum PomoTimers { twenty, twenty5, thirty, fifty }

class ModifyTimer extends StatefulWidget {
  final PomoTimers? selectedPomoTimer;

  const ModifyTimer({Key? key, this.selectedPomoTimer}) : super(key: key);

  @override
  State<ModifyTimer> createState() => _ModifyTimerState();
}

class _ModifyTimerState extends State<ModifyTimer> {
  PomoTimers? _pomoTimerop;

  @override
  void initState() {
    super.initState();
    _pomoTimerop = widget
        .selectedPomoTimer; // Marcar el RadioButton con la opción seleccionada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Barra superior de titulo y menú
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          toolbarHeight: 75,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          title: Text("Timer settings"),
          centerTitle: true,
          actions: [],
        ),
        body: SizedBox(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              RadioListTile<PomoTimers>(
                value: PomoTimers.twenty,
                groupValue: _pomoTimerop,
                onChanged: (PomoTimers? value) {
                  setState(() {
                    _pomoTimerop = value;
                  });
                  Navigator.pop(context, value);
                },
                title: Text("Intense 20/2"),
                subtitle: Text(
                    "For easily distracted individuals who prefer shorter breaks"),
              ),
              RadioListTile<PomoTimers>(
                value: PomoTimers.twenty5,
                groupValue: _pomoTimerop,
                onChanged: (PomoTimers? value) {
                  setState(() {
                    _pomoTimerop = value;
                  });
                  Navigator.pop(context, value);
                },
                title: Text("Classic 25/5"),
                subtitle: Text(
                    "Effective 25-minute focus with balanced short breaks."),
              ),
              RadioListTile<PomoTimers>(
                value: PomoTimers.thirty,
                groupValue: _pomoTimerop,
                onChanged: (PomoTimers? value) {
                  setState(() {
                    _pomoTimerop = value;
                  });
                  Navigator.pop(context, value);
                },
                title: Text("Extended 30/5"),
                subtitle: Text(
                    "Dive into focused study with 30 minutes of uninterrupted concentration."),
              ),
              RadioListTile<PomoTimers>(
                value: PomoTimers.fifty,
                groupValue: _pomoTimerop,
                onChanged: (PomoTimers? value) {
                  setState(() {
                    _pomoTimerop = value;
                  });
                  Navigator.pop(context, value);
                },
                title: Text("Comprehensive 50/10"),
                subtitle: Text(
                    "Ample time for deep study in 50 minutes with refreshing 10-minute breaks."),
              ),
            ],
          ),
        ));
  }
}
