<template>
  <div class="container">
    <h1>本棚</h1>
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
              <!-- TODO: 削除する場合は、book.idから削除する -->
              <!--<a :href="'/user_books/' + userBook.id" class="waves-effect waves-light btn red accent-3" rel="nofollow" data-method="delete">削除</a>-->
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
        user: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
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
        var authentication_token = localStorage.getItem('bookRecorderAuthenticationToken');
        if (authentication_token) {
          return authentication_token.split(':')[0];
        } else {
          location.href('/');
        }
      }
    }
  }
</script>

<style scoped>

</style>