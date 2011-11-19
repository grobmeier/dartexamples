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
      String url = 'http://localhost/dartexamples/dynamiclist/data.php?q=${element.value}';

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
    ul.elements.add(inner);
  }
}

void main() {
  new basicajax().run();
}
