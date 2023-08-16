import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_app/modifytimer.dart';
import 'package:pomodoro_app/help.dart';
import 'package:pomodoro_app/menu.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Variables para almacenar los intervalos de un Pomodoro
  int numeroIntervalos = 8;
  int contadorIntervalos = 0;

  /// Variables bandera
  bool isDescanso =
      false; // flag para saber si el intervalo es un descanso o no
  bool isStarted = false; //flag para controlar que se ha iniciado un intervalo
  bool pomoStarted = false; //flag para controlar que se ha iniciado un pomodoro

  /// Variable que cambiara segun el intervalo en el que nos encontremos
  int tiempoMinutos = 0;
  int tiempoSegundos = 0; // manipular el temporizador en segundos

  /// Variables que almacenan las duraciones de los intervalos por defecto
  int tiempoMinutosDescanso = 5;
  int tiempoMinutosPomodoro = 25;

  /// Opción por defecto del Pomodoro
  PomoTimers? _pomoTimerop = PomoTimers.twenty5;

  /// Funciones para el temporizador

  /// - Inicializamos las variables con los valores por defecto
  @override
  void initState() {
    super.initState();
    tiempoMinutos = tiempoMinutosPomodoro;
    tiempoSegundos = tiempoMinutosPomodoro * 60;
    //contadorIntervalos = contadorIntervalosPomodoro * 2; // nose pake
  }

  /// - Cuando accionamos el temporizador
  void toggleTimer() {
    setState(() {
      pomoStarted = true;
      isStarted = !isStarted; // ara si que se para el temporizador !!!
      isDescanso = !isDescanso;
    });

    if (isStarted) {
      _startTimer();
    }
  }

  /// Para imprimir el tiempo que le queda al temporizador
  String formatTime(int tiempoSegundos) {
    int minuts = tiempoSegundos ~/ 60;
    int segons = tiempoSegundos % 60;
    return '${minuts.toString().padLeft(2, '0')}:${segons.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    Future<void> updateTimer() async {
      while (isStarted && tiempoSegundos > 0) {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          tiempoSegundos--;
        });
      }

      // Lógica para finalizar el temporizador o iniciar el descanso, si corresponde.
      if (tiempoSegundos <= 0) {
        _cambiarTiempo();
      }
    }

    updateTimer();
  }

  void _cambiarTiempo() {
    setState(() {
      isStarted = false;

      if (contadorIntervalos % 2 == 0) {
        tiempoMinutos = tiempoMinutosDescanso;
      } else {
        tiempoMinutos = tiempoMinutosPomodoro;
      }

      tiempoSegundos = tiempoMinutos * 60;
      isDescanso = !isDescanso;
      contadorIntervalos++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is like a canvas (?)
    return Scaffold(
      drawer: MenuDrawer(),

      // Barra superior de titulo y menú
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        toolbarHeight: 75,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),

        // Titulo de la app
        title: Text("Pomodoro"),
        centerTitle: true,

        actions: [
          IconButton(
            icon: Icon(Icons.help_outlined),
            padding: EdgeInsets.all(24),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Help()));
            },
          )
        ],
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: CircularPercentIndicator(
              radius: 115.0,
              lineWidth: 8.0,
              percent: (tiempoSegundos / (tiempoMinutos * 60)),
              progressColor: Theme.of(context).colorScheme.primaryContainer,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(formatTime(tiempoSegundos),
                  style: TextStyle(fontSize: 42)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              // Usamos Column en lugar de Row para organizar los botones verticalmente
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: () {
                        toggleTimer();
                      },
                      child: isStarted
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                    ),
                    SizedBox(width: 75),
                    FilledButton.tonal(
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyTimer(
                                    selectedPomoTimer: _pomoTimerop)));

                        if (result != null) {
                          setState(() {
                            _pomoTimerop = result;
                            // Actualiza las variables de tiempo según la opción seleccionada
                            switch (result) {
                              case PomoTimers.twenty:
                                tiempoMinutosPomodoro = 20;
                                tiempoMinutosDescanso = 2;
                                break;
                              case PomoTimers.twenty5:
                                tiempoMinutosPomodoro = 25;
                                tiempoMinutosDescanso = 5;
                                break;
                              case PomoTimers.thirty:
                                tiempoMinutosPomodoro = 1;
                                tiempoMinutosDescanso = 3;
                                break;
                              case PomoTimers.fifty:
                                tiempoMinutosPomodoro = 50;
                                tiempoMinutosDescanso = 10;
                                break;
                            }

                            tiempoMinutos = tiempoMinutosPomodoro;
                            tiempoSegundos = tiempoMinutos * 60;
                          });
                        }
                      },
                      child: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ), // Espacio de separación entre los botones principales y el botón "Tasks"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 219, // Puedes ajustar el ancho del botón aquí
                      child: FilledButton.tonal(
                          onPressed: () {}, child: Text("Tasks")),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
