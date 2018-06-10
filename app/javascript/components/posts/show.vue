<template>
  <v-container fluid>
    <div class="display-1">{{ post.title }}</div>

    <v-layout row>
      <img src="https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png" :alt="post.title">
    </v-layout>

    <v-layout row wrap>
      {{ post.content }}
    </v-layout>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        post: []
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn', 'userId'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchPost(this.$route.params.id);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPost: function(postId) {
        request.get('/v1/posts/' + postId, {}).then((response) => {
          this.post = response.data.post;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      }
    }
  }
</script>

<style scoped>

</style>