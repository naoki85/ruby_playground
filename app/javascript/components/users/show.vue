<template>
  <v-container fluid>
    <v-layout row>
      <v-flex xs4>
        <img :src="user.avatar_image_path" width="100%">
      </v-flex>
      <v-flex xs8>
        <div class="display-1">{{ user.name }}</div>
      </v-flex>
    </v-layout>
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
            <!--<v-btn flat color="orange">Explore</v-btn>-->
          </v-card-actions>
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
        user: []
      }
    },
    mounted: function() {
      this.loading();
      this.fetchUser(this.$route.params.id);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchUser: function(userId) {
        request.get('/v1/users/' + userId, {}).then((response) => {
          this.user = response.data.user;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      redirectDetailPage(url) {
        location.href = url;
      }
    }
  }
</script>

<style scoped>

</style>