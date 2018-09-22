<template>
  <div>
    <!--<div class="siimple&#45;&#45;text-center" v-if="totalPage > 1">-->
      <!--<v-pagination :length="totalPage" v-model="page" color="teal" circle></v-pagination>-->
    <!--</div>-->
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div class="siimple-box siimple-grid-col siimple-grid-col--6 siimple-grid-col--sm-12"
             v-for="post in posts" :key="post.id">
          <router-link :to="'/posts/' + post.id">
            <div class="siimple-grid">
              <div class="siimple-grid-row">
                <div class="siimple-grid-col siimple-grid-col--9">
                  <div class="siimple-box-subtitle">
                    {{ post.published_at }}
                    <span class="siimple-tag siimple-tag-default siimple-tag--rounded"
                          :style="{backgroundColor: post.post_category.color}">
                      {{ post.post_category.name }}
                    </span>
                  </div>
                  <div class="siimple-box-title">{{ post.title }}</div>
                </div>
                <div class="siimple-grid-col siimple-grid-col--3">
                  <div class="siimple-box-detail">
                    <img :src="post.post_image_path" height="125px" :alt="post.title"/>
                  </div>
                </div>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
    <!--<div class="siimple&#45;&#45;text-center" v-if="totalPage > 1">-->
      <!--<v-pagination :length="totalPage" v-model="page" color="teal" circle></v-pagination>-->
    <!--</div>-->
  </div>
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
</style>