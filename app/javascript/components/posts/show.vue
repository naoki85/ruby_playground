<template>
  <v-container fluid>
    <div class="body-1 grey--text">{{ post.published_at }}</div>
    <div class="display-1">{{ post.title }}</div>
    <v-tweet-button :text="post.title" :path="path"></v-tweet-button>
    <v-hatebu-button :text="post.title" :path="path"></v-hatebu-button>

    <v-layout row wrap class="mt-large">
      <div class="preview-area">
        <div v-html="convertMarkdownToHtml"></div>
      </div>
    </v-layout>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'
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
      fetchPost: function(postId) {
        var get_params = '';
        if (this.loggedIn) {
          get_params += '?preview=true';
        }
        request.get('/v1/posts/' + postId + get_params, {}).then((response) => {
          this.post = response.data.post;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
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