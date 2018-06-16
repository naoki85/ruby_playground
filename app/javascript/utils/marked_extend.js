import marked from 'marked';

export default {
  extmarked: function(content) {
    var markedExtend = marked;
    var renderer = new markedExtend.Renderer();
    return marked(content, { renderer: renderer });
  }
}