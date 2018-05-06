<template>
  <div>
    <div class="row" v-for="comment in comments">
      <div class="col s12">
        <div class="card horizontal">
          <div class="card-image">
            <a :href="'/books/' + comment.book.id">
              <img :src="comment.book.image_url" :alt="comment.book.title">
            </a>
          </div>
          <div class="card-stacked">
            <div class="card-content">
              <p>{{ comment.comment }}</p>
            </div>
            <div class="card-action avatar-below-card">
              <span class="grey-text left-align">{{ comment.created_at }}</span>
              <a :href="'/users/' + comment.user.id">
                <img class="circle responsive-img" :src="comment.user.avatar_image_path" :alt="comment.user.name">
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    data: function() {
      return {
        comments: []
      }
    },
    mounted: function() {
      console.log(this.$store.getters.auth);
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active')
      this.fetchComments();
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active')
    },
    methods: {
      fetchComments: function() {
        axios.get('/v1/user_book_comments').then((response) => {
          for(var i = 0; i < response.data.user_book_comments.length; i++) {
            console.log(response.data.user_book_comments[i]);
            this.comments.push(response.data.user_book_comments[i]);
          }
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>