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

    <v-layout row wrap class="mt-default">
      <v-flex xs12 md6 v-for="item in items" :key="item.id">
        <v-card color="" class="black--text" :to="'books/' + item.id">
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="headline">{{ item.title }}</div>
                  <div>{{ item.book_category }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <v-card-media
                    :src="item.image_url"
                    height="125px"
                    :alt="item.title"
                    contain
                ></v-card-media>
              </v-flex>
            </v-layout>
            <v-layout row>
              <v-card-actions>
                <v-btn color="teal" @click="onAddBook(item)">
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
        items: []
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
        if (!this.keyword) {
          this.isError = true;
          return;
        }
        this.items = [];

        request.get('/v1/books/search',
            { params: { keyword: this.keyword }, auth: true }).
        then((response) => {
          if (response.data.results.length > 0) {
            this.items = response.data.results;
          } else {
            this.isError = true;
          }
          this.isLoading = false;
        }, (error) => {
          console.log(error);
        });
      },
      onAddBook(book) {
        if (!book) {
          this.isError = true;
          return;
        }
        this.loading();
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.post('/v1/user_books',
            { params: { user_book: book }, headers: { Authorization: authenticateToken } }).
        then((response) => {
          this.isCreated = true;
        }, (error) => {
          console.log(error);
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>

</style>