#import('dart:dom', prefix:'dom');
#import('dart:html');

class AudioPlayer {
   var _playButton;   
   dom.AudioContext audioContext;
   dom.AudioBufferSourceNode source;
   dom.AudioGainNode gainNode;

   AudioPlayer() {
     _playButton = document.query("#play");
     audioContext = new dom.AudioContext();
     gainNode = audioContext.createGainNode();
     
     source = audioContext.createBufferSource();
     source.connect(gainNode, 0, 0);
     _playButton.on.click.add((e) {
        source.noteOn(0);
     });

     gainNode.connect(audioContext.destination, 0, 0);
     
     document.query("#volume").on.change.add((e) {
       var volume = Math.parseInt(e.target.value);
       var max = Math.parseInt(e.target.max);
       var fraction = volume / max;
       gainNode.gain.value = fraction * fraction;
     });
  }

  void _loadSound(String name) {
     dom.XMLHttpRequest xhr = new dom.XMLHttpRequest();
     xhr.open("GET", name, true);
     xhr.responseType = "arraybuffer";
     xhr.addEventListener('load', (e) {
       audioContext.decodeAudioData(xhr.response, function(buffer) {
         source.buffer = buffer;
         _playButton.disabled = false;
       }, function() {
         print('Error decoding MP3 file');
       });
     });
     xhr.send();
  }
}

main() {
  var audioPlayer = new AudioPlayer();
  audioPlayer._loadSound("test.mp3");
}