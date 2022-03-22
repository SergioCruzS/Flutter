import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class SliderScreen extends StatefulWidget {
   
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  double _sliderValue = 100;
  bool _sliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
        centerTitle: true,
      ),
      body: Column(
        children: [
      
          Slider.adaptive(
            min: 50,
            max: 400,
            activeColor: AppTheme.primary,
            value: _sliderValue,
            onChanged: _sliderEnabled 
            ? ( value ) {
                _sliderValue = value;
                setState(() {});
            }
            : null
          ),
          CheckboxListTile(
            activeColor: AppTheme.primary,
            title: const Text('Habilitar Slider'),
            value: _sliderEnabled, 
            onChanged: ( value ) => setState(() { _sliderEnabled = value ?? true; })
          ),

          SwitchListTile.adaptive(
            activeColor: AppTheme.primary,
            title: const Text('Habilitar Slider'),
            value: _sliderEnabled, 
            onChanged: ( value ) => setState(() { _sliderEnabled = value; })
          ),

          const AboutListTile(),

          Expanded(
            child: SingleChildScrollView(
              child: Image(
                image: const NetworkImage('https://autotest.com.ar/wp-content/uploads/2021/02/FORD-F-150-RAPTOR.jpg'),
                fit: BoxFit.contain,
                width: _sliderValue,
              ),
            ),
          ),

      
        ],
      )
    );
  }
}