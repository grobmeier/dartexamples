#library('walkingdiv');

#import('dart:html');

// Public, to let others change the size of this field
int fieldsize = 9;

SpanElement _numberOfSelected;

class _Field {
  _Field top;
  _Field bottom;
  _Field left;
  _Field right;
  
  DivElement element;
  // Coordinates
  int x, y;
  
  bool selected = false;
  
  _Field(int x, int y) : this.withNeighbour(x, y, null, null); 
  
  _Field.withNeighbour(int this.x, int this.y, this.top, this.left) {
    element = new Element.tag('div');
    //element.style.setProperty('float', 'left');
    element.style.setProperty('border', '1px solid black');
    element.style.setProperty('height', '50px');
    element.style.setProperty('width', '50px');
    element.style.setProperty('float', 'left');
    element.style.setProperty('text-align', 'center');
    element.style.setProperty('margin-right', '10px');
    element.style.setProperty('line-height', '50px');
    element.innerHTML = x.toString() + " / " + y.toString();
   
    element.on.click.add((e) {
      selected = true;
      element.classes.add('selected');
      
      _numberOfSelected.innerHTML = document.queryAll('.selected').length.toString();
    });
  }
  
  void paintTo(DivElement panel) {
    
    if(x == 0) {
      //document.query('#status').innerHTML = "OK";
      DivElement row = new Element.tag('div');
      row.style.setProperty('height', '60px');
      
      row.elements.add(element);
      right.paintTo(row);
      panel.elements.add(row);
      if(bottom != null) {
        bottom.paintTo(panel);
      }
    } else {
      panel.elements.add(element);
      if(right != null) {
        right.paintTo(panel);
      }
    }
  }
  
  void createNeighbours() {
    if(x < fieldsize) {
      right = new _Field.withNeighbour( x + 1, y, this.top, this);
      right.createNeighbours();
    } 
    
    if(x == 0 && y < fieldsize) {
      bottom = new _Field.withNeighbour( x, y + 1, this, null);
      bottom.createNeighbours();
    }
  }
}

class WalkingDiv {
  DivElement _panel;
  
  _Field _topLeft;
  _Field _selected;
  
  WalkingDiv() {
    _panel = document.query('#panel');
  }

  void paint() {
    _topLeft.paintTo(_panel);
  }
  
  void run() {
    _selected = new _Field(0, 0);
    
    _selected.createNeighbours();
    _selected.selected = true;
    
    _topLeft = _selected;
    
    paint();
    //_panel.elements.add();
  }

}

void main() {
  _numberOfSelected = document.query('#numberOfSelected');
  new WalkingDiv().run();
}
