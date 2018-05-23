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
        <v-layout row wrap v-for="book in getBooks" :key="book.id">
          <v-flex xs4>
            <router-link :to="'/books/' + book.id">
              <img :src="book.image_url" :alt="book.title" width="100%">
            </router-link>
          </v-flex>
          <v-flex xs8>
            <div class="title">{{ book.title }}</div>
            <div class="subheading">{{ book.author }}</div>
            <div class="subheading">{{ '発売日：' + book.published_at }}</div>
          </v-flex>
        </v-layout>
        <div class="align-center" v-if="getFlg">
          <v-btn @click="fetchBooks(active)">さらに読み込む</v-btn>
        </div>
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
        thisMonthBooks: [],
        thisMonthOffset: 0,
        thisMonthNextFlg: true,
        nextMonthBooks: [],
        nextMonthOffset: 0,
        nextMonthNextFlg: true
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
      },
      getFlg: function() {
        if (this.active == 1) {
          return this.thisMonthNextFlg;
        } else {
          return this.nextMonthNextFlg;
        }
      }
    },
    watch: {

    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPublisher: function(publisherId) {
        request.get('/v1/publishers/' + publisherId, {}).then((response) => {
          this.publisher = response.data.publisher;
          this.fetchBooks(0);
          this.fetchBooks(1);
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      loadNextBooks: function(active) {
        this.loading();
        this.fetchBooks(active);
        this.finish();
      },
      fetchBooks: function(active) {
        if (active == 1) {
          var offset = this.nextMonthOffset;
          var date = this.getFormattedDate('next_month');
        } else {
          var offset = this.thisMonthOffset;
          var date = this.getFormattedDate('this_month');
          var end_date = this.getFormattedDate('end_of_this_month');
        }
        var params = '?publisher_id=' + this.publisher.id + '&start_date=' + date + '&offset=' + offset;
        if (active == 0) {
          params += '&end_date=' + end_date;
        }

        request.get('/v1/books' + params, {}).then((response) => {
          if (response.data.books.length < 1) {
            if (active == 1) {
              this.nextMonthNextFlg = false;
            } else {
              this.thisMonthNextFlg = false;
            }
          }
          for(var i = 0; i < response.data.books.length; i++) {
            if (active == 1) {
              this.nextMonthBooks.push(response.data.books[i]);
            } else {
              this.thisMonthBooks.push(response.data.books[i]);
            }
          }
          if (active == 1) {
            this.nextMonthOffset += 10;
          } else {
            this.thisMonthOffset += 10;
          }
        }, (error) => {
          console.log(error);
        });
      },
      // next_month
      // end_of_this_month
      getFormattedDate: function(mode) {
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1;
        if (mode == 'end_of_this_month') {
          var day = new Date(year, month, 0).getDate();
        } else {
          var day = '01';
        }
        if (mode == 'next_month') {
          month++;
          if (month > 12) {
            year++;
          }
        }
        if (month < 10) {
          month = '0' + month;
        }
        return year + '-' + month + '-' + day;
      }
    }
  }
</script>

<style scoped>
  .mt-default {
    margin-top: 30px;
  }
  .align-center {
    text-align: center !important;
  }
</style>