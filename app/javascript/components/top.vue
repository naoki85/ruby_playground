<template>
  <div class="container">
    <h1>最近追加された本</h1>
    <div class="row">本を追加してコメントを残そう!!</div>
    <div v-if="loggedIn" class="row">
      <router-link to="/books/search" class="waves-effect btn grey lighten-5 black-text">本を探す</router-link>
      <router-link to="/user_books" class="waves-effect btn grey lighten-5 black-text">本棚</router-link>
    </div>
    <div v-else class="row">
      <router-link to="/sign_up" class="waves-effect waves-teal btn">新規登録</router-link>
      <router-link to="/sign_in" class="waves-effect waves-teal btn">ログイン</router-link>
    </div>
    <div class="row" v-for="comment in comments">
      <div class="col s12">
        <div class="card horizontal">
          <div class="card-image">
            <router-link :to="'/books/' + comment.book.id">
              <img :src="comment.book.image_url" :alt="comment.book.title">
            </router-link>
          </div>
          <div class="card-stacked">
            <div class="card-content">
              <p>{{ comment.comment }}</p>
            </div>
            <div class="card-action avatar-below-card">
              <span class="grey-text left-align">{{ comment.created_at }}</span>
              <router-link :to="'/users/' + comment.user.id">
                <img class="circle responsive-img" :src="comment.user.avatar_image_path" :alt="comment.user.name">
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'
  import { mapState } from 'vuex'
  import loading from './commons/loading'

  export default {
    data: function() {
      return {
        comments: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    mounted: function() {
      this.showLoading();
      this.fetchComments();
      this.hideLoading();
    },
    methods: {
      fetchComments: function() {
        request.get('/v1/user_book_comments', {}).then((response) => {
          this.comments = response.data.user_book_comments;
        }, (error) => {

        });
      }
    },
    mixins: [loading]
  }
</script>

<style scoped>

</style>