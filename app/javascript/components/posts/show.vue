<template>
  <v-container fluid>
    <div class="display-1">{{ post.title }}</div>

    <v-layout row>
      <img src="https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png" :alt="post.title">
    </v-layout>

    <v-layout row v-if="enableControl()">
      <v-btn
          color="orange white--text"
          :to="'/posts/edit/' + post.id"
      >
        編集
        <v-icon color="white">edit</v-icon>
      </v-btn>
      <v-btn color="red white--text" @click="onDeletePost(post.id)">
        削除
        <v-icon color="white">delete</v-icon>
      </v-btn>
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
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchPost: function(postId) {
        request.get('/v1/posts/' + postId, {}).then((response) => {
          this.post = response.data.post;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      enableControl: function() {
        if (this.loggedIn) {
          if (this.userId == this.post.user_id) {
            return true;
          }
        }
        return false;
      },
      onDeletePost: function(postId) {
        request.delete('/v1/posts/' + postId, { auth: true }).then((response) => {
          this.showSuccessAlert({ message: '削除しました' });
          this.$router.push('/posts');
        }, (error) => {
          this.showErrorAlert({ message: '削除に失敗しました' });
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>