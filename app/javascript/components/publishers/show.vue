<template>
  <div class="container">
    <h1>Publisher name</h1>
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
            </div>
            <div class="card-action">
              <a class="waves-effect btn grey lighten-5 black-text"
                 :href="book.detail_page_url">確認</a>
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