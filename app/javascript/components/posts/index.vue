<template>
  <div>
    <v-paginate :current-page="page" :total-page="totalPage"
                @click-page="fetchPosts" ref="paginate"></v-paginate>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div class="siimple-box siimple-grid-col siimple-grid-col--6 siimple-grid-col--md-12"
             v-for="post in posts" :key="post.id">
          <router-link :to="'/posts/' + post.id">
            <div class="siimple-grid">
              <div class="siimple-grid-row">
                <div class="siimple-grid-col siimple-grid-col--8">
                  <div class="siimple-box-subtitle">
                    {{ post.published_at }}
                    <span class="siimple-tag siimple-tag-default siimple-tag--rounded"
                          :style="{backgroundColor: post.post_category.color}">
                      {{ post.post_category.name }}
                    </span>
                  </div>
                  <div class="siimple-box-title box-title">{{ post.title }}</div>
                </div>
                <div class="siimple-grid-col siimple-grid-col--4">
                  <div class="siimple-box-detail">
                    <img :src="post.post_image_path" :alt="post.title"/>
                  </div>
                </div>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
    <v-paginate :current-page="page" :total-page="totalPage"
                @click-page="fetchPosts" ref="paginate"></v-paginate>
  </div>
</template>

<script>
  import Paginate from '../commons/paginate'
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
    components: {
      'v-paginate': Paginate
    },
    watch: {
      page: function() {
        this.$refs.paginate.updateCurrent(this.page)
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
          this.page = page;
        }, (error) => {
          console.log(error);
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>
  .siimple-box {
    margin-bottom: 0;
    background-color: white;
  }
  .siimple-box-title {
    font-size: 24px;
    color: #000000;
  }
  .siimple-box-title:hover {
    text-decoration: underline;
  }
  .siimple-box-subtitle {
    font-size: 13px;
    color: #9e9e9e;
  }
  .siimple-tag-default {
    color: white;
  }
  .siimple-box-detail {
    opacity: 1.0;
    height: 125px;
  }
  .siimple-box-detail img {
    width: 100%;
    height: auto;
  }
</style>