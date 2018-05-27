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

    <line-chart></line-chart>

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
  import lineChart from '../commons/line_chart'

  export default {
    components: {
      'line-chart': lineChart
    },
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