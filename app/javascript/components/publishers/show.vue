<template>
  <v-container fluid>
    <div class="display-1">{{ publisher.name }}</div>
    <v-tabs
        v-model="active"
        color="blue-grey lighten-5"
        dark
        slider-color="red"
        class="mt-default"
    >
      <v-tab
          v-for="tab in tabList"
          :key="tab.name"
          ripple
          class="black--text"
      >
        {{ tab.name }}
      </v-tab>
      <v-tab-item
          v-for="tab in tabList"
          :key="tab.name"
          class="mt-default"
      >
        <v-layout row wrap v-for="book in getBooks" :key="book.title">
          <v-flex xs4>
            <router-link :to="'/books/' + book.id">
              <img :src="book.image_url" :alt="book.title" width="100%">
            </router-link>
          </v-flex>
          <v-flex xs8>
            <div class="title">{{ book.title }}</div>
            <div class="subheading">{{ '発売日：' + book.published_at }}</div>
          </v-flex>
        </v-layout>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function () {
      return {
        active: null,
        tabList: [{name: '今月'}, {name: '来月'}],
        publisher: [],
        books: [],
        thisMonthBooks: [],
        nextMonthBooks: []
      }
    },
    mounted: function () {
      this.loading();
      this.fetchPublisher(this.$route.params.id);
      this.finish();
    },
    computed: {
      getBooks: function() {
        if (this.active == 1) {
          return this.nextMonthBooks;
        } else {
          return this.thisMonthBooks;
        }
      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPublisher: function (publisherId) {
        request.get('/v1/publishers/' + publisherId, {}).then((response) => {
          this.publisher = response.data.publisher;
          this.setPublishBooks(response.data.publisher.books)
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      setPublishBooks: function(books) {
        var today = new Date();
        var beginningOfMonth = new Date();
        beginningOfMonth.setDate(1);
        var endOfMonth = new Date();
        endOfMonth.setDate(0);
        endOfMonth.setMonth(today.getMonth());

        books.forEach((book) => {
          var publishedAt = new Date(book.published_at);
          if (publishedAt >= beginningOfMonth && publishedAt <= endOfMonth) {
            this.thisMonthBooks.push(book);
          } else if (publishedAt > endOfMonth) {
            this.nextMonthBooks.push(book);
          }
        });
      }
    }
  }
</script>

<style scoped>
  .mt-default {
    margin-top: 30px;
  }
</style>