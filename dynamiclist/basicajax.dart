#import('dart:html');
#import("dart:json");

class basicajax {
  InputElement _search = null;
  Element _data = null;
  
  basicajax() {
    _search = document.query('.search');
    _data = document.query('#data');
  }

  void run() {
    _search.on.keyUp.add( _(Event event) {
      XMLHttpRequest request = new XMLHttpRequest();
      String url = 'http://localhost/dartexamples/dynamiclist/data.php?q=${_search.value}';

      request.open("GET", url, true);
      
      request.on.load.add((event) {
        this.resetData();
        List<String> result = JSON.parse(request.responseText);
        result.forEach((element) {
          this.addRow(element);
        });
      });
      request.send();
      
    });
    this.addRow("Type one or more letters");
  }

  void resetData() {
    _data.nodes.clear();
  }
  
  void addRow(String message) {
    Element inner = new Element.tag('li');
    inner.innerHTML = message;
    _data.elements.add(inner);
  }
}

void main() {
  new basicajax().run();
}
