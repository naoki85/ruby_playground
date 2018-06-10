<template>
  <v-container fluid>
    <div class="display-1">記事一覧</div>
    <v-layout row wrap>
      <v-flex xs12 md6 v-for="post in posts" :key="post.id">
        <v-card color="" class="black--text">
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="headline">{{ post.title }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <router-link :to="'/posts/' + post.id">
                  <v-card-media
                      src="https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png"
                      height="125px"
                      :alt="post.title"
                      contain
                  ></v-card-media>
                </router-link>
              </v-flex>
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
        posts: []
      }
    },
    mounted: function() {
      this.loading();
      this.fetchPosts();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPosts: function() {
        request.get('/v1/posts', { }).then((response) => {
          this.posts = response.data.posts;
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>