<template>
  <v-container fluid>
    <div class="display-1">{{ publisher.name }}</div>
    <v-tabs
        v-model="active"
        color="teal lighten-3"
        dark
        slider-color="orange"
        class="mt-default"
    >
      <v-tab
          v-for="tab in tabList"
          :key="tab.name"
          ripple
      >
        {{ tab.name }}
      </v-tab>
      <v-tab-item
          v-for="tab in tabList"
          :key="tab.name"
          class="mt-default"
      >
        <v-layout row wrap v-for="book in publisher.books" :key="book.title">
          <v-flex xs4>
            <router-link :to="'/books/' + book.id">
              <img :src="book.image_url" :alt="book.title" width="100%">
            </router-link>
          </v-flex>
          <v-flex xs8>
            <div class="title">{{ book.title }}</div>
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
        books: []
      }
    },
    mounted: function () {
      this.loading();
      this.fetchPublisher(this.$route.params.id);
      this.finish();
    },
    computed: {
      // toggleMessage() {
      //   var today = new Date();
      //   // 今月始め
      //   var beginningOfMonth = new Date();
      //   beginningOfMonth.setDate(1);
      //   // 月終わり
      //   var endOfMonth = new Date();
      //   endOfMonth.setDate(0);
      //   // 来月
      //   var nextMonth;

      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      fetchPublisher: function (publisherId) {
        request.get('/v1/publishers/' + publisherId, {}).then((response) => {
          console.log(response.data.publisher);
          this.publisher = response.data.publisher;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
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