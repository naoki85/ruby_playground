<template>
  <v-container fluid>
    <div class="display-1">本棚</div>
    <v-layout row wrap class="mt-default">
      <v-flex xs12 md6 v-for="book in user.books" :key="book.id">
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
                <v-btn flat color="orange" @click="redirectDetailPage(book.detail_page_url)">公式ページへ</v-btn>
                <v-btn flat color="red" @click="deleteUserBook(book.id)">本棚から削除</v-btn>
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
  .mt-default {
    margin-top: 20px;
  }
</style>