import marked from 'marked';

export default {
  extmarked: function(content) {
    if (!content) { return ''; }
    var markedExtend = marked;
    var renderer = new markedExtend.Renderer();
    return marked(content, { renderer: renderer });
  }
}