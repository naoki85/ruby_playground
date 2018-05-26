<template>
  <v-container fluid>
    <div class="display-1">本棚</div>
    <v-layout row wrap class="mt-default">
      <v-flex xs12 md6 v-for="user_book in user_books" :key="user_book.id">
        <v-card color="" class="black--text">
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="headline">{{ user_book.book.title }}</div>
                  <div>{{ user_book.book.book_category }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <router-link :to="'/books/' + user_book.book.id">
                  <v-card-media
                      :src="user_book.book.image_url"
                      height="125px"
                      :alt="user_book.book.title"
                      contain
                  ></v-card-media>
                </router-link>
              </v-flex>
            </v-layout>
            <v-layout row>
              <v-card-actions>
                <v-btn flat color="orange" @click="redirectDetailPage(user_book.book.detail_page_url)">公式ページへ</v-btn>
                <v-btn flat color="red" @click="deleteUserBook(user_book.book.id)">本棚から削除</v-btn>
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
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        user_books: []
      }
    },
    computed: {
      ...mapState('auth', [
        'userId'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchUserBooks();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchUserBooks: function() {
        request.get('/v1/user_books', { auth: true }).then((response) => {
          this.user_books = response.data.user_books;
        }, (error) => {
          console.log(error);
        });
      },
      deleteUserBook: function(bookId) {
        this.loading();
        request.delete('/v1/user_books', { params: { book_id: bookId }, auth: true })
            .then((response) => {
          this.showSuccessAlert({
            message: '削除が完了しました'
          });
          this.fetchUserBooks();
        }, (error) => {
          this.showErrorAlert({
            message: '削除が失敗しました'
          });
          console.log(error);
        });
        this.finish();
      },
      redirectDetailPage(url) {
        location.href = url;
      }
    }
  }
</script>

<style scoped>
  .mt-default {
    margin-top: 20px;
  }
</style>