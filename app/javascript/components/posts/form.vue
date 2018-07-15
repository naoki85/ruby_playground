<template>
  <div>
    <v-layout row>
      <v-text-field v-model="title" label="タイトル"></v-text-field>
    </v-layout>

    <v-layout row>
      <v-flex v-if="postImagePath" xs4 md2>
        <img :src="postImagePath" width="100%">
      </v-flex>
      <v-flex xs8 md10>
        <input @change="selectedFile" type="file" name="image">
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex xs12 sm6 md4>
        <v-menu
            ref="menu"
            :close-on-content-click="false"
            :nudge-right="40"
            :return-value.sync="publishedAt"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
        >
          <v-text-field
              slot="activator"
              v-model="publishedAt"
              label="Picker without buttons"
              prepend-icon="event"
              readonly
          ></v-text-field>
          <v-date-picker v-model="publishedAt" @input="$refs.menu.save(publishedAt)"></v-date-picker>
        </v-menu>
      </v-flex>
      <v-flex xs12 sm6 md4>
        <v-radio-group v-model="active">
          <v-radio label="下書き中" :value="0"></v-radio>
          <v-radio label="公開" :value="1"></v-radio>
        </v-radio-group>
      </v-flex>
    </v-layout>

    <v-layout row>
      <v-flex xs12 sm6>
        <v-text-field v-model="content" label="本文" multi-line rows="100" class="input-content-area border-line"></v-text-field>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="preview-area">
          <div v-html="convertMarkdownToHtml" class="input-content-area"></div>
        </div>
      </v-flex>
    </v-layout>

    <div class="bottom-fixed grey lighten-4">
      <v-btn v-if="editFlag" color="teal white--text" @click="onUpdatePost">
        編集
        <v-icon color="white">edit</v-icon>
      </v-btn>
      <v-btn v-else color="teal white--text" @click="onCreatePost">
        作成
        <v-icon color="white">add</v-icon>
      </v-btn>
    </div>
  </div>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'
  import markedExtend from '../../utils/marked_extend';

  export default {
    props: {
      editFlag: Boolean
    },
    data: function() {
      return {
        title: '',
        content: '',
        publishedAt: '',
        active: 0,
        image: '',
        postImagePath: '',
        modal: false,
      }
    },
    mounted: function() {
      if (this.editFlag) {
        this.loading();
        this.fetchPost(this.$route.params.id);
        this.finish();
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn', 'userId'
      ]),
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.content);
      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchPost: function(postId) {
        request.get('/v1/posts/' + postId + '?preview=true', {}).then((response) => {
          this.setPost(response.data.post);
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      onUpdatePost: function() {
        this.loading();
        var postId = this.$route.params.id;
        let formData = this.setPostForm();
        request.patch('/v1/posts/' + postId, { params: formData, auth: true })
            .then((response) => {
              this.showSuccessAlert({ message: '編集しました' });
              this.$router.push('/posts/' + postId);
            }, (error) => {
              this.showErrorAlert({ message: '編集に失敗しました' });
              console.log(error);
            });
        this.finish();
      },
      onCreatePost: function() {
        this.loading();
        let formData = this.setPostForm();
        request.post('/v1/posts', { params: formData, headers: { 'content-type': 'multipart/form-data' }, auth: true })
            .then((response) => {
          this.showSuccessAlert({ message: '作成しました' });
          this.$router.push('/posts');
        }, (error) => {
          this.showErrorAlert({ message: '作成に失敗しました' });
          console.log(error);
        });
        this.finish();
      },
      selectedFile: function(e) {
        e.preventDefault();
        let files = e.target.files;
        this.image = files[0];
      },
      setPostForm: function() {
        let formData = new FormData();
        formData.append('image', this.image);
        formData.append('title', this.title);
        formData.append('content', this.content);
        formData.append('active', this.active);
        formData.append('published_at', this.publishedAt);
        return formData;
      },
      setPost: function(post) {
        this.title = post.title;
        this.content = post.content;
        this.publishedAt = post.published_at;
        if (post.active === 'published') {
          this.active = 1;
        } else {
          this.active = 0;
        }
        this.postImagePath = post.post_image_path;
      }
    }
  }
</script>

<style>
  .bottom-fixed {
    position: fixed;
    bottom: 0;
    border-top: groove 1px #4DB6AC;
    width: 100%;
    text-align: right;
    padding-right: 50px;
  }
  .input-content-area {
    padding: 10px;
  }
  .border-line {
    border-right: groove 1px #4DB6AC;
  }
</style>