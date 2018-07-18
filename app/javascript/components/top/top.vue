<template>
  <v-container fluid grid-list-lg>
    <div class="display-1">最近追加された本</div>
    <v-layout row class="image-slide-box">
      <div class="image-list">
        <div v-for="book in books" class="image" @click="openDialog(book)">
          <img :src="book.image_url" :alt="book.title">
        </div>
      </div>
    </v-layout>
    <v-list subheader>
      <v-subheader>新刊情報</v-subheader>
      <v-list-tile v-for="publisher in publishers" :key="publisher.id"
                   :to="'publishers/' + publisher.id">
        <v-list-tile-action>
          <v-icon>book</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title v-html="publisher.name"></v-list-tile-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-icon>chevron_right</v-icon>
        </v-list-tile-action>
      </v-list-tile>
    </v-list>
    <book-dialog :dialog="dialog"
                 :title="dialogBook.title"
                 :detailPageUrl="dialogBook.detail_page_url"
                 :imageUrl="dialogBook.image_url"
                 v-on:close-dialog="resetDialogParams"
    >
    </book-dialog>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'
  import dialogMixin from '../books/dialog_mixin'

  export default {
    mixins: [dialogMixin],
    data: function() {
      return {
        publishers: [],
        books: []
      }
    },
    mounted: function() {
      this.loading();
      this.fetchPublishers();
      this.fetchRecentBooks();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchRecentBooks: function() {
        request.get('/v1/books?mode=recent', { })
            .then((response) => {
          this.books = response.data.books;
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
  .image-slide-box {
    margin-top: 20px;
    height: 200px;
  }
  .image-list {
    position: absolute;
    left: 0px;
    width: 1200px;
    height: 200px;
    overflow: hidden;
    animation: slide-image-list 20s linear 0s 1 normal none running;
  }
  .image-list > .image {
    float: left;
    padding: 10px;
  }
  .image img {
    width: 100px;
    max-height: 200px;
  }
  @keyframes slide-image-list {
    0% {
      left: 0;
    }
    50% {
      left: -400px;
    }
    100% {
      left: -800px;
    }
  }
</style>