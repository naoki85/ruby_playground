<template>
  <div class="siimple-grid">
    <div class="siimple-grid-row">
      <div @dragleave.prevent="onDragLeave" @dragover.prevent="onDragEnter" @drop.prevent="uploadImage"
           class="siimple-grid-col siimple-grid-col--6 siimple-grid-col--xs-12">
        <textarea v-model="content" class="edit-text siimple-textarea siimple-textarea--fluid"
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
  import request from '../../utils/requests';

  export default {
    props: {
      name: String,
      content: String
    },
    data: function() {
      return {
        uploading: false
      }
    },
    computed: {
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.content);
      }
    },
    methods: {
      onDragEnter() {
        this.toggleDragOver('enter');
      },
      onDragLeave() {
        this.toggleDragOver('leave');
      },
      toggleDragOver(action) {
        let targetClassList = document.getElementsByClassName('edit-text')[0].classList;
        const targetClass = 'dropover';
        if (action === 'enter') {
          targetClassList.add(targetClass);
        } else {
          targetClassList.remove(targetClass);
        }
      },
      uploadImage(event) {
        if (this.uploading) { return; }
        this.uploading = true;
        let formData = new FormData();
        formData.append('file', event.dataTransfer.files[0]);

        request.post('/v1/posts/upload', { params: formData })
        .then((response) => {
          let image_url = response.data.image_url;
          let img_tag = '<img src="' + image_url + '">';
          document.getElementsByClassName('edit-text')[0].value += img_tag;
        }, (error) => {
          console.log(error);
          alert('画像のアップロードに失敗しました。再度お試しください。')
        });
        this.toggleDragOver('leave');
        this.uploading = false;
      }
    }
  }
</script>

<style scoped>
  .input-content-area {
    padding: 10px;
  }
  .drop-area {
    border-radius: 3px;
  }
  .dropover {
    border-color: #2188ff;
    box-shadow: inset 0 1px 2px rgba(27,31,35,0.075), 0 0 0 0.2em rgba(3,102,214,0.3);
  }
</style>