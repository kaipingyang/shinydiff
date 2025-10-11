HTMLWidgets.widget({
  name: 'shinydiff',
  type: 'output',
  factory: function(el, width, height) {
    var diffLib = null;
    function renderDiff(text1, text2) {
      if (!diffLib) return;
      var diff = diffLib.diffWords(text1, text2);
      var fragment = document.createDocumentFragment();
      diff.forEach(function(part){
        var color = part.added ? 'green' : part.removed ? 'red' : 'grey';
        var span = document.createElement('span');
        span.style.color = color;
        span.appendChild(document.createTextNode(part.value));
        fragment.appendChild(span);
      });
      el.innerHTML = '';
      el.appendChild(fragment);
    }
    return {
      renderValue: function(x) {
        if (!diffLib) {
          // Load diff library if not loaded
          if (typeof Diff !== 'undefined') {
            diffLib = Diff;
            renderDiff(x.text1, x.text2);
          } else {
            var script = document.createElement('script');
            script.src = 'https://cdn.jsdelivr.net/npm/diff@5.2.0/dist/diff.min.js';
            script.onload = function() {
              diffLib = Diff;
              renderDiff(x.text1, x.text2);
            };
            document.head.appendChild(script);
          }
        } else {
          renderDiff(x.text1, x.text2);
        }
      },
      resize: function(width, height) {}
    };
  }
});
