<template>
  <div>
    <div class="row margin-default-top">
      <div class="col s4">
        <img :src="user.avatar_image_path" width="100%">
      </div>
      <div class="col s8">
        <h1>{{ user.name }}</h1>
      </div>
    </div>
    <div class="row" v-for="book in user.books">
      <div class="row">
        <div class="col s12">
          <div class="card horizontal">
            <div class="card-image">
              <a :href="'/books/' + book.id">
                <img :src="book.image_url" :alt="book.title">
              </a>
            </div>
            <div class="card-stacked">
              <div class="card-content">
                <p>{{ book.title }}</p>
                <p>{{ book.book_category }}</p>
              </div>
              <div class="card-action">
                <a :href="book.detail_page_url" v-if="book.detail_page_url.match(/www\.amazon\.co\.jp/)">
                  <img src="https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/btn_amazon.png">
                </a>
                <a class="waves-effect btn grey lighten-5 black-text"
                   :href="book.detail_page_url" v-else>確認</a>
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

  export default {
    data: function() {
      return {
        user: []
      }
    },
    mounted: function() {
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
      this.fetchUser(this.$route.params.id);
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
    },
    methods: {
      fetchUser: function(userId) {
        request.get('/v1/users/' + userId, {}).then((response) => {
          this.user = response.data.user;
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>