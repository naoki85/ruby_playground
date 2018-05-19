<template>
  <v-container fluid grid-list-lg>
    <div class="display-1">新刊</div>
    <div v-for="publisher in publishers" :key="publisher.id" class="publisher-area">
      <v-layout row>
        <router-link :to="'/publishers/' + publisher.id" class="headline">
          <div class="headline">{{ publisher.name }}</div>
        </router-link>
      </v-layout>
      <v-layout row class="book-list">
        <div v-for="book in publisher.books" :key="book.id">
          <img :src="book.image_url" :alt="book.title">
        </div>
      </v-layout>
    </div>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        publishers: []
      }
    },
    mounted: function() {
      this.loading();
      this.fetchPublishers();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchComments: function() {
        request.get('/v1/user_book_comments', {}).then((response) => {
          this.comments = response.data.user_book_comments;
        }, (error) => {

        });
      },
      fetchPublishers: function() {
        request.get('/v1/publishers', {}).then((response) => {
          this.publishers = response.data.publishers;
        }, (error) => {

        });
      }
    }
  }
</script>

<style scoped>
  .publisher-area {
    margin-top: 30px;
  }
  .book-list {
    margin-top: 15px !important;
  }
  .book-list img {
    width: 100px;
    max-height: 200px;
  }
</style>