import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/provider/pvpoprovider.dart';

class Pannel extends StatefulWidget {
  int position; // position 0 means the upper mat and the possition 1
  Pannel({Key key, this.position}) : super(key: key);

  @override
  State<Pannel> createState() => _PannelState();
}

class _PannelState extends State<Pannel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 3,
      child: GridView.builder(
        itemCount: 9,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: MediaQuery.of(context).size.width * 1 / 60,
            crossAxisSpacing: MediaQuery.of(context).size.width * 1 / 50,
            childAspectRatio: 1 / 0.5),
        itemBuilder: (context, index) {
          final data = Provider.of<PvPOData>(context, listen: true);
          return DragTarget<int>(
            builder: (BuildContext context, List<dynamic> candidateData,
                List<dynamic> rejectedData) {
              return (widget.position == 0
                          ? data.upMat
                          : data.downMat)[index] ==
                      0
                  ? Container(
                      height: MediaQuery.of(context).size.width * 1 / 40,
                      width: MediaQuery.of(context).size.width * 1 / 40,
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.position == 0
                            ? Color.fromRGBO(127, 255, 170, 0.5)
                            : Color.fromRGBO(65, 105, 225, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.width * 1 / 40,
                      width: MediaQuery.of(context).size.width * 1 / 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.position == 0
                              ? Color.fromRGBO(107, 235, 150, 1)
                              : Color.fromRGBO(65, 105, 225, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        (widget.position == 0
                                ? data.upMat
                                : data.downMat)[index]
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
            },
            onAccept: (int something) {
              if ((widget.position == 0 ? data.upMat : data.downMat)[index] ==
                      0 &&
                  data.turn == widget.position) {
                setState(() {
                  (widget.position == 0 ? data.upMat : data.downMat)[index] =
                      something;
                  data.updatemat(
                      (widget.position == 0 ? data.upMat : data.downMat),
                      index,
                      context);
                  print((widget.position == 0 ? data.upMat : data.downMat));
                });
                print('onAccept:$something');
              }
            },
          );
        },
      ),
    );
  }
}

class Pannelai extends StatefulWidget {
  Pannelai({
    Key key,
  }) : super(key: key);

  @override
  State<Pannelai> createState() => _PannelaiState();
}

class _PannelaiState extends State<Pannelai> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PvPOData>(context, listen: true);
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 3,
      child: GridView.builder(
        itemCount: 9,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: MediaQuery.of(context).size.width * 1 / 60,
            crossAxisSpacing: MediaQuery.of(context).size.width * 1 / 50,
            childAspectRatio: 1 / 0.5),
        itemBuilder: (context, index) {
          return data.upMat[index] == 0
              ? Container(
                  height: MediaQuery.of(context).size.width * 1 / 40,
                  width: MediaQuery.of(context).size.width * 1 / 40,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(127, 255, 170, 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.width * 1 / 40,
                  width: MediaQuery.of(context).size.width * 1 / 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(107, 235, 150, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    data.upMat[index].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
        },
      ),
    );
  }
}

class NumSource extends StatefulWidget {
  NumSource({Key key}) : super(key: key);

  @override
  State<NumSource> createState() => _NumSourceState();
}

class _NumSourceState extends State<NumSource> {
  @override
  Widget build(BuildContext context) {
    final gamedata = Provider.of<PvPOData>(context, listen: true);
    print("turn=${gamedata.turn}");
    if (gamedata.turn == 2 ||
        gamedata.randomNum == 0 ||
        gamedata.remember != gamedata.turn) {
      return Container(
        height: MediaQuery.of(context).size.width * 1 / 7,
        width: MediaQuery.of(context).size.width * 1 / 7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(10, 150, 150, 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Color.fromRGBO(100, 100, 0, 1), fontSize: 18),
          child: Text(" "),
        ),
      );
    }

    return Draggable<int>(
      data: gamedata.getNum,
      child: Container(
        height: MediaQuery.of(context).size.width * 1 / 7,
        width: MediaQuery.of(context).size.width * 1 / 7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: gamedata.turn == 0
                ? Color.fromRGBO(107, 235, 150, 1)
                : Color.fromRGBO(65, 105, 225, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          gamedata.getNum.toString(),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      feedback: Container(
        height: MediaQuery.of(context).size.width * 1 / 7,
        width: MediaQuery.of(context).size.width * 1 / 7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: gamedata.turn == 0
                ? Color.fromRGBO(107, 235, 150, 1)
                : Color.fromRGBO(65, 105, 225, 1),
            borderRadius: BorderRadius.circular(10)),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Colors.white, fontSize: 18),
          child: Text(gamedata.getNum.toString()),
        ),
      ),
    );
  }
}
