<template>
  <v-container fluid>
    <div class="display-1">編集</div>

    <v-layout row>
      <v-text-field v-model="title" label="タイトル"></v-text-field>
    </v-layout>

    <v-layout row>
      <v-text-field v-model="summary" label="要約" multi-line></v-text-field>
    </v-layout>

    <v-layout row>
      <v-flex xs4 md2>
        <img :src="postImagePath" width="100%">
      </v-flex>
      <v-flex xs8 md10>
        <input @change="selectedFile" type="file" name="image">
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex xs12 sm6 md4>
        <v-dialog
            ref="dialog"
            v-model="modal"
            :return-value.sync="publishedAt"
            persistent
            lazy
            full-width
            width="290px"
        >
          <v-text-field
              slot="activator"
              v-model="publishedAt"
              label="Picker without buttons"
              prepend-icon="event"
              readonly
              class="input-published-at"
          ></v-text-field>
          <v-date-picker v-model="publishedAt" scrollable color="teal">
            <v-spacer></v-spacer>
            <v-btn flat color="primary" @click="modal = false">Cancel</v-btn>
            <v-btn flat color="primary" @click="$refs.dialog.save(publishedAt)">OK</v-btn>
          </v-date-picker>
        </v-dialog>
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
        <v-text-field v-model="content" label="本文" multi-line rows="100"></v-text-field>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="preview-area">
          <div v-html="convertMarkdownToHtml"></div>
        </div>
      </v-flex>
    </v-layout>

    <v-btn color="teal white--text" @click="onUpdatePost">
      編集
      <v-icon color="white">edit</v-icon>
    </v-btn>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'
  import markedExtend from '../../utils/marked_extend';

  export default {
    data: function() {
      return {
        title: '',
        summary: '',
        content: '',
        publishedAt: '',
        active: 0,
        image: '',
        postImagePath: '',
        modal: false
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
    mounted: function() {
      this.loading();
      this.fetchPost(this.$route.params.id);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchPost: function(postId) {
        request.get('/v1/posts/' + postId, {}).then((response) => {
          var post = response.data.post;
          this.title = post.title;
          this.summary = post.summary;
          this.content = post.content;
          this.publishedAt = post.publishedAt;
          if (post.active === 'published') {
            this.active = 1;
          } else {
            this.active = 0;
          }
          this.postImagePath = post.post_image_path;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      onUpdatePost: function() {
        this.loading();
        var postId = this.$route.params.id;
        let formData = new FormData();
        formData.append('image', this.image);
        formData.append('title', this.title);
        formData.append('summary', this.summary);
        formData.append('content', this.content);
        formData.append('active', this.active);
        formData.append('published_at', this.publishedAt);
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
      selectedFile: function(e) {
        e.preventDefault();
        let files = e.target.files;
        this.image = files[0];
      }
    }
  }
</script>

<style>

</style>