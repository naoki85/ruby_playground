<template>
  <v-container fluid>
    <div class="display-1">本棚</div>
    <v-layout row wrap>
      <v-flex xs12 sm6 offset-sm3 v-for="book in user.books" :key="book.title">
        <v-card>
          <v-card-media :src="book.image_url" height="200px" :alt="book.title">
          </v-card-media>
          <v-card-title primary-title>
            <div>
              <h3 class="headline mb-0">{{ book.title }}</h3>
              <div>{{ book.book_category }}</div>
            </div>
          </v-card-title>
          <v-card-actions>
            <v-btn flat color="orange" @click="redirectDetailPage(book.detail_page_url)">公式ページへ</v-btn>
            <v-btn flat color="red" @click="deleteUserBook(book.id)">本棚から削除</v-btn>
          </v-card-actions>
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
        user: []
      }
    },
    computed: {
      ...mapState('auth', [
        'userId'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchUser(this.userId);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchUser: function(userId) {
        request.get('/v1/users/' + userId, {}).then((response) => {
          this.user = response.data.user;
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
          var userId = this.userId;
          this.fetchUser(userId);
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

</style>