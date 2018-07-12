<template>
  <v-container fluid>
    <div class="body-1 grey--text">{{ post.published_at }}</div>
    <div class="display-1">{{ post.title }}</div>
    <v-tweet-button :text="post.title" :path="path"></v-tweet-button>
    <v-hatebu-button :text="post.title" :path="path"></v-hatebu-button>

    <v-layout row v-if="enableControl()">
      <v-btn
          color="orange white--text"
          :to="'/posts/edit/' + post.id"
      >
        編集
        <v-icon color="white">edit</v-icon>
      </v-btn>
      <v-btn color="red white--text" @click="onDeletePost(post.id)">
        削除
        <v-icon color="white">delete</v-icon>
      </v-btn>
    </v-layout>

    <v-layout row wrap class="mt-large">
      <div class="preview-area">
        <div v-html="convertMarkdownToHtml"></div>
      </div>
    </v-layout>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'
  import markedExtend from '../../utils/marked_extend';
  import tweetButton from '../commons/tweet_button';
  import hatebuButton from '../commons/hatebu_button';

  export default {
    components: {
      'v-tweet-button': tweetButton,
      'v-hatebu-button': hatebuButton,
    },
    data: function() {
      return {
        post: [],
        path: ''
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn', 'userId'
      ]),
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.post.content);
      }
    },
    mounted: function() {
      this.path = this.$route.path;
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
          this.post = response.data.post;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      enableControl: function() {
        if (this.loggedIn) {
          if (this.userId == this.post.user_id) {
            return true;
          }
        }
        return false;
      },
      onDeletePost: function(postId) {
        request.delete('/v1/posts/' + postId, { auth: true }).then((response) => {
          this.showSuccessAlert({ message: '削除しました' });
          this.$router.push('/posts');
        }, (error) => {
          this.showErrorAlert({ message: '削除に失敗しました' });
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>
  .mt-large {
    margin-top: 30px;
  }
  .preview-area {
    width: 100%;
  }
</style>