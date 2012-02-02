#import('dart:html');

class ClickDiv {
  ClickDiv() {
    DivElement _clickRegion = document.query("#clickMe");
    
    _clickRegion.on.click.add((e) {
      if(_clickRegion.style.backgroundColor == "rgb(255, 170, 170)") {
        _clickRegion.style.backgroundColor = "#aaaaff";
      } else {
        _clickRegion.style.backgroundColor = "#ffaaaa";
      }
    });
  }
}

void main() {
  new ClickDiv();
}
