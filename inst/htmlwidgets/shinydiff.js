HTMLWidgets.widget({
  name: 'shinydiff',
  type: 'output',
  factory: function(el, width, height) {
    var diffLib = null;
    function renderDiff(text1, text2, diffType) {
      if (!diffLib) return;
      // var diff = diffLib.diffWords(text1, text2);
      var diff;
      if (diffType === "chars") {
        diff = diffLib.diffChars(text1, text2);
      } else if (diffType === "words") {
        diff = diffLib.diffWords(text1, text2);
      } else if (diffType === "lines") {
        diff = diffLib.diffLines(text1, text2);
      } else if (diffType === "sentences") {
        diff = diffLib.diffSentences(text1, text2);
      } else if (diffType === "trimmedlines") {
        diff = diffLib.diffTrimmedLines(text1, text2);
      } else if (diffType === "css") {
        diff = diffLib.diffCss(text1, text2);
      } else {
        diff = diffLib.diffWords(text1, text2); // default fallback
      }
      var fragment = document.createDocumentFragment();
      diff.forEach(function(part){
        var color = part.added ? 'green' : part.removed ? 'red' : 'grey';
        var span = document.createElement('span');
        span.style.color = color;
        // span.appendChild(document.createTextNode(part.value));
        if (part.removed) {
          // 删除内容加删除线
          var del = document.createElement('del');
          del.appendChild(document.createTextNode(part.value));
          span.appendChild(del);
        } else {
          span.appendChild(document.createTextNode(part.value));
        }
        fragment.appendChild(span);
      });
      // Create a container with adaptive height and scroll
      var container = document.createElement('div');
      container.className = 'shinydiff-output';
      container.style.width = '100%';
      container.style.height = '100%';
      container.style.maxHeight = '70vh'; // adaptive to viewport
      container.style.overflowY = 'auto'; // scroll if overflow
      container.style.fontFamily = 'monospace';
      container.style.fontSize = '14px';
      container.style.lineHeight = '1.4';
      container.style.border = '1px solid #ddd';
      container.style.padding = '10px';
      container.style.backgroundColor = 'white';
      container.appendChild(fragment);
      el.innerHTML = '';
      el.appendChild(container);

      // The diff result is sent back to the R side
      if (window.Shiny && el.id) {
        Shiny.setInputValue(el.id + "_diff", JSON.stringify(diff), {priority: "event"});
      }
    }
    return {
      renderValue: function(x) {
        if (!diffLib) {
          // Load diff library if not loaded
          if (typeof Diff !== 'undefined') {
            diffLib = Diff;
            renderDiff(x.text1, x.text2, x.diffType);
          } else {
            var script = document.createElement('script');
            script.src = 'https://cdn.jsdelivr.net/npm/diff@5.2.0/dist/diff.min.js';
            script.onload = function() {
              diffLib = Diff;
              renderDiff(x.text1, x.text2, x.diffType);
            };
            document.head.appendChild(script);
          }
        } else {
          renderDiff(x.text1, x.text2, x.diffType);
        }
      },
      resize: function(width, height) {}
    };
  }
});
