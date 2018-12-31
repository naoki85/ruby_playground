<template>
  <div>
    <div class="body-1 grey--text">{{ post.published_at }}</div>
    <h1 class="siimple-h1">{{ post.title }}</h1>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <v-tweet-button :text="post.title" :path="path"></v-tweet-button>
        <v-hatebu-button :text="post.title" :path="path"></v-hatebu-button>
      </div>
    </div>

    <div class="preview-area">
      <div v-html="convertMarkdownToHtml"></div>
    </div>
    <recommend-books :recommend-books="recommendBooks"></recommend-books>
  </div>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'
  import markedExtend from '../../utils/marked_extend';
  import tweetButton from '../commons/tweet_button';
  import hatebuButton from '../commons/hatebu_button';
  import recommendBooks from '../commons/recommend_books';

  export default {
    components: {
      'v-tweet-button': tweetButton,
      'v-hatebu-button': hatebuButton,
      'recommend-books': recommendBooks
    },
    data: function() {
      return {
        post: [],
        path: '',
        recommendBooks: []
      }
    },
    computed: {
      convertMarkdownToHtml: function() {
        return markedExtend.extmarked(this.post.content);
      }
    },
    mounted: function() {
      this.path = this.$route.path;
      this.fetchPost(this.$route.params.id);
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPost: function(postId) {
        this.loading();
        request.get('/v1/posts/' + postId, {}).then((response) => {
          this.post = response.data.post;
          this.recommendBooks = response.data.recommended_books;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        }).then(() => {
          this.finish();
        });
      }
    }
  }
</script>

<style scoped>
  .siimple-h1 {
    font-size: 34px;
  }
  .preview-area {
    width: 100%;
  }
</style>