<template>
  <div class="container">
    <h1>本棚</h1>
    <p v-if="isDeleted" class="alert alert-success">削除しました。</p>
    <div v-for="book in user.books" class="row">
      <div class="col s12">
        <div class="card horizontal">
          <div class="card-image">
            <img :src="book.image_url" :alt="book.title">
          </div>
          <div class="card-stacked">
            <div class="card-content">
              <p>{{ book.title }}</p>
              <p>{{ book.book_category }}</p>
            </div>
            <div class="card-action">
              <router-link :to="'/books/' + book.id" class="waves-effect btn grey lighten-5 black-text">確認</router-link>
              <button @click="deleteUserBook(book.id)" class="waves-effect waves-light btn red accent-3">削除</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState } from 'vuex'
  import loading from '../commons/loading'

  export default {
    data: function() {
      return {
        user: [],
        isDeleted: false
      }
    },
    computed: {
      ...mapState('auth', [
        'userId'
      ])
    },
    mounted: function() {
      this.showLoading();
      this.fetchUser(this.userId);
      this.hideLoading();
    },
    methods: {
      fetchUser: function(userId) {
        request.get('/v1/users/' + userId, {}).then((response) => {
          this.user = response.data.user;
        }, (error) => {
          console.log(error);
        });
      },
      deleteUserBook: function(bookId) {
        this.showLoading();
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.delete('/v1/user_books', { params: { book_id: bookId }, auth: true })
            .then((response) => {
          this.isDeleted = true;
          var userId = this.userId;
          this.fetchUser(userId);
        }, (error) => {
          console.log(error);
        });
        this.hideLoading();
      }
    },
    mixins: [loading]
  }
</script>

<style scoped>

</style>