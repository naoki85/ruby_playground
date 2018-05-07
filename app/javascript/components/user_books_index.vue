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
              <a :href="'/books/' + book.id" class="waves-effect btn grey lighten-5 black-text">確認</a>
              <button @click="deleteUserBook(book.id)" class="waves-effect waves-light btn red accent-3">削除</button>
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
        user: [],
        isDeleted: false
      }
    },
    mounted: function() {
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
      var userId = this.getUserId();
      this.fetchUser(userId);
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
    },
    methods: {
      fetchUser: function(userId) {
        request.get('/v1/users/' + userId, {}).then((response) => {
          this.user = response.data.user;
        }, (error) => {
          console.log(error);
        });
      },
      getUserId: function() {
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        if (authenticateToken) {
          return authenticateToken.split(':')[0];
        } else {
          location.href('/');
        }
      },
      deleteUserBook: function(bookId) {
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.delete('/v1/user_books', { params: { book_id: bookId }, headers: { Authorization: authenticateToken } }).then((response) => {
          this.isDeleted = true;
          var userId = this.getUserId();
          this.fetchUser(userId);
        }, (error) => {
          console.log(error);
        });
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
      }
    }
  }
</script>

<style scoped>

</style>