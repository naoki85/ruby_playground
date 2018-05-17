<template>
  <v-container fluid grid-list-lg>
    <div class="display-1">最近追加された本</div>
    <div>本を追加してコメントを残そう!!</div>
    <div v-if="loggedIn">
      <!--<router-link to="/books/search" class="waves-effect btn grey lighten-5 black-text">本を探す</router-link>-->
      <router-link to="/user_books" class="btn">本棚</router-link>
    </div>
    <div v-else>
      <router-link to="/sign_up" class="btn">新規登録</router-link>
      <router-link to="/sign_in" class="btn">ログイン</router-link>
    </div>
    <v-layout row wrap>
      <v-flex xs12 sm6 lg4 v-for="comment in comments" :key="comment.id">
        <v-card>
          <v-container fluid grid-list-lg>
            <v-layout row>
              <v-flex xs7>
                <div>
                  <div class="headline">
                    <router-link :to="'/users/' + comment.user.id">
                      <img :src="comment.user.avatar_image_path" :alt="comment.user.name">
                    </router-link>
                    <span class="body-2 grey--text">{{ comment.created_at }}</span>
                  </div>
                  <div>{{ comment.comment }}</div>
                </div>
              </v-flex>
              <v-flex xs5>
                <router-link :to="'/books/' + comment.book.id">
                  <v-card-media
                      :src="comment.book.image_url"
                      :alt="comment.book.title"
                      height="125px"
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
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        comments: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchComments();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchComments: function() {
        request.get('/v1/user_book_comments', {}).then((response) => {
          this.comments = response.data.user_book_comments;
        }, (error) => {

        });
      }
    }
  }
</script>

<style scoped>
  .headline img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
  }
</style>