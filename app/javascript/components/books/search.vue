<template>
  <v-container fluid>
    <div class="display-1">本を探す</div>
    <div>
      <v-layout row>
        <v-text-field v-model="keyword" label="キーワード"></v-text-field>
      </v-layout>

      <v-btn @click="onBookSearch">
        探す
        <v-icon>search</v-icon>
      </v-btn>
    </div>

    <v-layout v-if="isError" row wrap class="mt-default">
      <v-alert :value="isError" outline color="error" icon="warning">
        検索条件に当てはまる本が見つかりませんでした
      </v-alert>
    </v-layout>
    <v-layout v-else row wrap class="mt-default">
      <v-flex xs12 md6 v-for="book in books" :key="book.id">
        <v-card color="" class="black--text">
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="headline">{{ book.title }}</div>
                  <div>{{ book.book_category }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <router-link :to="'/books/' + book.id">
                  <v-card-media
                      :src="book.image_url"
                      height="125px"
                      :alt="book.title"
                      contain
                  ></v-card-media>
                </router-link>
              </v-flex>
            </v-layout>
            <v-layout row>
              <v-card-actions>
                <v-btn color="teal white--text" @click="onAddBook(book.id)">
                  追加
                  <v-icon>add</v-icon>
                </v-btn>
              </v-card-actions>
            </v-layout>
          </v-container>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        keyword: '',
        books: [],
        isError: false
      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      onBookSearch() {
        this.isError = false;
        if (!this.keyword) {
          this.isError = true;
          return;
        }
        this.loading();
        this.books = [];

        request.get('/v1/books/search?keyword=' + this.keyword, { auth: true })
            .then((response) => {
          if (response.data.books.length > 0) {
            this.books = response.data.books;
          } else {
            this.isError = true;
          }
        }, (error) => {
          console.log(error);
          this.isError = true;
        });
        this.finish();
      },
      onAddBook(bookId) {
        if (!bookId) {
          this.showErrorAlert({
            message: '追加失敗しました'
          });
          return;
        }
        this.loading();
        request.post('/v1/user_books', { params: { user_book: { book_id: bookId } }, auth: true })
            .then((response) => {
          this.showSuccessAlert({
            message: '追加しました'
          });
        }, (error) => {
          console.log(error);
          this.showErrorAlert({
            message: '追加失敗しました'
          });
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>
  .mt-default {
    margin-top: 20px;
  }
</style>