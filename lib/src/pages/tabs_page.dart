import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

import 'tab2_page.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
          create: (_) => new _NavegacionModel(),
          child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados'))
      ],
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }

}

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int pagina) {
    this._paginaActual = pagina;
    _pageController.animateToPage(pagina, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}