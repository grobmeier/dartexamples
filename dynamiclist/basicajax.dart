#import('dart:html');
#import("dart:json");

class basicajax {
  Console _console = null;

  basicajax() {
    _console = window.console;
  }

  void run() {
    InputElement element = document.query('.search');
    element.on.keyUp.add( _(Event event) {
      XMLHttpRequest request = new XMLHttpRequest();
      String url = 'http://localhost/dart/data.php?q=${element.value}';

      request.open("GET", url, false);
      
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
    document.query('#data').nodes.clear();
  }
  
  void addRow(String message) {
    Element ul = document.query('#data');
    
    Element inner = new Element.tag('li');
    inner.innerHTML = message;
    
    ElementList list = ul.elements;
    list.add(inner);
  }
}

void main() {
  basicajax b = new basicajax();
  
  b.run();
}
