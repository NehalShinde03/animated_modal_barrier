import 'package:flutter/material.dart';

class AnimatedModalBarrierExample extends StatefulWidget {
  const AnimatedModalBarrierExample({super.key});

  @override
  State<AnimatedModalBarrierExample> createState() => _AnimatedModalBarrierExampleState();
}

class _AnimatedModalBarrierExampleState extends State<AnimatedModalBarrierExample>
          with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<Color?> _animationColor;

  @override
  void initState(){
    ColorTween colorTween = ColorTween(
      begin: null,
      end: Colors.grey.withOpacity(0.6)
    );

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    );
    _animationColor = colorTween.animate(_animationController);
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }

  double _changeOpacityValue = 1.0;


  void _changeOpacity(){
    setState(() {
      _changeOpacityValue = _changeOpacityValue==1.0 ? 0.0 : 1.0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
              _changeOpacity();
          }, icon: const Icon(Icons.ads_click))
        ],
      ),

      body: Stack(

          children: [

            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _changeOpacityValue,
                duration: const Duration(seconds: 1),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                ),
              ),
            ),
            AnimatedModalBarrier(color: _animationColor)

          ],

        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          setState(() {

            if(_animationController.status == AnimationStatus.completed){
              _animationController.reverse();
            }
            else{
              _animationController.forward();
            }
          });
        },
      ),
    );
  }
}
