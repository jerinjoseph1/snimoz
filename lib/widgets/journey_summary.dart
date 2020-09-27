import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'dart:math' as math;
import 'package:syncfusion\_flutter\_gauges/gauges.dart';



var speedData = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

var data = [0.0, 2.0, 1.5, 3.0, 0.0, 1.0, -0.5, -1.0, -0.5, 0.0, 0.0];

Widget JourneySummary(){
  return Padding(
    padding: const EdgeInsets.only(left:00.0,right: 00),
    child: Container(
      height: 260,
      child: Card(
        child: Stack(
          children: [
           // Padding(
           //    padding: const EdgeInsets.all(20.0),
           //    child: Center(child: Text (" Speed Log", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
           //  ),

              // child: SfRadialGauge(
              //     axes: <RadialAxis>[
              //       RadialAxis(minimum: 0, maximum: 150,
              //           ranges: <GaugeRange>[
              //             GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
              //             GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
              //             GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
              //           pointers: <GaugePointer>[
              //             NeedlePointer(value: 120)],
              //           annotations: <GaugeAnnotation>[
              //             GaugeAnnotation(widget: Container(child:
              //             Text('90',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
              //                 angle: 90, positionFactor: 0.5
              //             )]
              //       )]),

           // Padding(
           //     padding: const EdgeInsets.all(20.0),
           //     child: Sparkline(
           //        data: speedData,
           //
           //      ),
           //   ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Sparkline(
                data: data,
                lineColor: Colors.red,

              ),
            ),


         ],
        ),
      ),
    ),
  );
}

