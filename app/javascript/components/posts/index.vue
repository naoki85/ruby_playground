<template>
  <v-container fluid>
    <div class="display-1">記事一覧</div>
    <div class="text-xs-center" v-if="totalPage > 1">
      <v-pagination :length="totalPage" v-model="page" color="teal" circle></v-pagination>
    </div>
    <v-layout row wrap class="mt-large">
      <v-flex xs12 md6 v-for="post in posts" :key="post.id">
        <v-card color="" class="black--text" :to="'/posts/' + post.id">
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="body-2 grey--text">
                    {{ post.published_at }}
                    <v-chip text-color="white" :style="{backgroundColor: post.post_category.color}">{{ post.post_category.name }}</v-chip>
                  </div>
                  <div class="headline">{{ post.title }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <v-card-media
                    :src="post.post_image_path"
                    height="125px"
                    :alt="post.title"
                    contain
                ></v-card-media>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card>
      </v-flex>
    </v-layout>
    <div class="text-xs-center" v-if="totalPage > 1">
      <v-pagination :length="totalPage" v-model="page" color="teal" circle></v-pagination>
    </div>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        posts: [],
        totalPage: 0,
        page: 1
      }
    },
    watch: {
      page: function() {
        this.fetchPosts(this.page);
      }
    },
    mounted: function() {
      this.fetchPosts();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPosts: function(page) {
        this.loading();
        request.get('/v1/posts?page=' + page, { }).then((response) => {
          this.totalPage = response.data.total_page;
          this.posts = response.data.posts;
        }, (error) => {
          console.log(error);
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>
  .mt-large {
    margin-top: 30px;
  }
</style>