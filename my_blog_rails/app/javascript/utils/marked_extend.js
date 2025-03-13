import marked from 'marked';
import hljs from 'highlight.js'

export default {
  extmarked: function(content) {
    if (!content) { return ''; }
    var markedExtend = marked;
    var renderer = new markedExtend.Renderer();

    renderer.code = function (code, lang) {
      return '<pre><code class="' +
          lang +
          '">' + hljs.highlightAuto(code).value + '</code></pre>';
    }
    return marked(content, { renderer: renderer });
  }
}