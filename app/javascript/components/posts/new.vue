<template>
  <v-container fluid>
    <div class="display-1">新規作成</div>

    <v-layout row>
      <v-text-field v-model="title" label="タイトル"></v-text-field>
    </v-layout>

    <v-layout row>
      <v-text-field v-model="summary" label="要約" multi-line></v-text-field>
    </v-layout>

    <v-layout row>
      <input @change="selectedFile" type="file" name="image">
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
        <v-text-field v-model="content" label="本文" multi-line rows="100"></v-text-field>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="preview-area">
          <div v-html="convertMarkdownToHtml"></div>
        </div>
      </v-flex>
    </v-layout>

    <v-btn color="teal white--text" @click="onCreatePost">
      作成
      <v-icon color="white">add</v-icon>
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
        image: ''
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
      onCreatePost: function() {
        this.loading();
        let formData = new FormData();
        formData.append('image', this.image);
        formData.append('title', this.title);
        formData.append('summary', this.summary);
        formData.append('content', this.content);
        formData.append('active', this.active);
        formData.append('published_at', this.publishedAt);
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
      }
    }
  }
</script>

<style>

</style>