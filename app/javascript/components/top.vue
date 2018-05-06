<template>
  <div>
    <h1>最近追加された本</h1>
    <div class="row">本を追加してコメントを残そう!!</div>
    <div class="row">
      <router-link to="/users/sign_up" class="waves-effect waves-teal btn">新規登録</router-link>
      <router-link to="/users/sign_in" class="waves-effect waves-teal btn">ログイン</router-link>
    </div>
    <div class="row" v-for="comment in comments">
      <div class="col s12">
        <div class="card horizontal">
          <div class="card-image">
            <a :href="'/books/' + comment.book.id">
              <img :src="comment.book.image_url" :alt="comment.book.title">
            </a>
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

  export default {
    data: function() {
      return {
        comments: []
      }
    },
    mounted: function() {
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active')
      this.fetchComments();
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active')
    },
    methods: {
      fetchComments: function() {
        request.get('/v1/user_book_comments').then((response) => {
          for(var i = 0; i < response.data.user_book_comments.length; i++) {
            console.log(response.data.user_book_comments[i]);
            this.comments.push(response.data.user_book_comments[i]);
          }
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>