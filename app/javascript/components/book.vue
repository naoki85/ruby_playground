<template>
  <div class="container">
    <h1>{{ book.title }}</h1>

    <div class="row">
      <img :src="book.image_url" :alt="book.title">
    </div>

    <!--<div v-if="loggedIn" class="row">-->
      <!--<input type="text">-->
    <!--</div>-->

    <div v-for="user_book_comment in book.user_book_comments" class="col s12 m8 offset-m2 l6 offset-l3">
      <div class="card-panel z-depth-1">
        <div class="row valign-wrapper">
          <div class="col s2">
            <router-link :to="'/users/' + user_book_comment.user.id">
              <img :src="user_book_comment.user.avatar_image_path"
                   :alt="user_book_comment.user.name"
                   class="circle responsive-img">
            </router-link>
          </div>
          <div class="col s9">
            <span class="black-text">{{ user_book_comment.comment }}</span>
            <p class="margin-default-top.right-align.grey-text">{{ user_book_comment.created_at }}</p>
          </div>
          <div class="col s1">
            <div v-if="loggedIn">
              <div class="row">
                <a href="/user_book_comments/edit">
                  <i class="material-icons">edit</i>
                </a>
              </div>
              <div class="row">
                <a href="/user_book_comments/edit">
                  <i class="material-icons">delete</i>
                </a>
              </div>
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

  export default {
    data: function() {
      return {
        book: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    mounted: function() {
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active')
      this.fetchBook(this.$route.params.id);
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active')
    },
    methods: {
      fetchBook: function(bookId) {
        request.get('/v1/books/' + bookId, {}).then((response) => {
          this.book = response.data.book;
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>