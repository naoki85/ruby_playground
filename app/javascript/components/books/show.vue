<template>
  <v-container fluid>
    <div class="display-1">{{ book.title }}</div>

    <v-layout row>
      <img :src="book.image_url" :alt="book.title">
    </v-layout>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        book: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn', 'userId'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchBook(this.$route.params.id);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchBook: function(bookId) {
        request.get('/v1/books/' + bookId, {}).then((response) => {
          this.book = response.data.book;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      reloadBook: function() {
        this.book = [];
        this.fetchBook(this.$route.params.id);
      },
      pushUserShow: function(userId) {
        this.$router.push('/users/' + userId);
      }
    }
  }
</script>

<style>
  .mt-large {
    margin-top: 50px;
  }
  .mt-default {
    margin-top: 20px;
  }
</style>