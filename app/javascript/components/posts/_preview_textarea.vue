<template>
  <div>
    <div class="siimple-modal siimple-modal--medium" id="modal" style="display:none;">
      <div class="siimple-modal-content">
        <div class="siimple-modal-header">
          <div class="siimple-modal-header-title">Enter URL</div>
          <div class="siimple-modal-header-close" id="modal-close" @click="modalClose"></div>
        </div>
        <div class="siimple-modal-body">
          <input v-model="insert_link" type="text" class="siimple-input siimple-input--fluid">
        </div>
        <div class="siimple-modal-footer">
          <button type="button" @click="getOGP" class="siimple-btn siimple-btn--primary">Add</button>
        </div>
      </div>
    </div>
    <div class="siimple-btn siimple-btn--primary" id="modal-open" @click="modalOpen">Open modal</div>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div @dragleave.prevent="onDragLeave" @dragover.prevent="onDragEnter" @drop.prevent="uploadImage"
             class="siimple-grid-col siimple-grid-col--6 siimple-grid-col--xs-12">
          <textarea v-model="input_text" class="edit-text siimple-textarea siimple-textarea--fluid"
                    rows="100" :name="name" id="post_content"></textarea>
        </div>
        <div class="siimple-grid-col siimple-grid-col--6 siimple-grid-col--xs-12">
          <div class="preview-area">
            <div v-html="convertMarkdownToHtml" class="input-content-area"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import markedExtend from '../../utils/marked_extend';
  import request from '../../utils/requests';
  import { mapActions } from 'vuex'

  export default {
    props: {
      name: String,
      content: String
    },
    data: function() {
      return {
        uploading: false,
        input_text: '',
        insert_link: ''
      }
    },
    mounted: function() {
      this.input_text = this.content;
    },
    computed: {
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.input_text);
      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
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
        this.loading();
        let formData = new FormData();
        formData.append('file', event.dataTransfer.files[0]);

        request.post('/v1/posts/upload', { params: formData })
        .then((response) => {
          let image_url = response.data.image_url;
          let img_tag = '<img src="' + image_url + '" width="100%">';
          this.input_text += img_tag;
        }, (error) => {
          console.log(error);
          alert('画像のアップロードに失敗しました。再度お試しください。')
        }).then(() => {
          this.finish();
        });
        this.toggleDragOver('leave');
        this.uploading = false;
      },
      modalOpen() {
        document.getElementById("modal").style.display = "";
      },
      modalClose() {
        document.getElementById("modal").style.display = "none";
      },
      getOGP() {
        let param = encodeURI(this.insert_link);
        this.modalClose();
        this.insert_link = '';
        request.get('/v1/posts/ogp?url=' + param, {})
        .then((response) => {
          var insert_tag = '<a href="' + response.data.url + '">';
          insert_tag += '<div class="ogp-card">';
          insert_tag += '<div class="siimple-grid-row">';
          insert_tag += '<div class="siimple-card siimple-grid-col siimple-grid-col--4 left">';
          insert_tag += '<img src="' + response.data.image_url + '" width="100%">';
          insert_tag += '</div>';
          insert_tag += '<div class="siimple-card siimple-grid-col siimple-grid-col--8 right">';
          insert_tag += '<div class="siimple-card-title">' + response.data.title + '</div>';
          insert_tag += '<div class="siimple-card-description">';
          insert_tag += response.data.description;
          insert_tag += '</div>';
          insert_tag += '</div>';
          insert_tag += '</div>';
          insert_tag += '<div class="siimple-grid-row bottom-description">';
          insert_tag += response.data.description;
          insert_tag += '</div>';
          insert_tag += '</div>';
          insert_tag += '</a>';
          this.input_text += insert_tag;
        }, (error) => {
          console.log(error);
        });
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