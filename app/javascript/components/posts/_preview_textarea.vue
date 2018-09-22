<template>
  <div class="siimple-grid">
    <div class="siimple-grid-row">
      <div class="siimple-grid-col siimple-grid-col--6 siimple-grid-col--xs-12">
        <textarea v-model="content" class="siimple-textarea siimple-textarea--fluid"
                  rows="100" :name="name" id="post_content"></textarea>
      </div>
      <div class="siimple-grid-col siimple-grid-col--6 siimple-grid-col--xs-12">
        <div class="preview-area">
          <div v-html="convertMarkdownToHtml" class="input-content-area"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import markedExtend from '../../utils/marked_extend';

  export default {
    props: {
      name: String,
      content: String
    },
    computed: {
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.content);
      }
    }
  }
</script>

<style scoped>
  .input-content-area {
    padding: 10px;
  }
</style>