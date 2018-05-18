<template>
  <v-footer height="auto" class="teal">
    <v-layout row wrap justify-center>
      <v-btn
          v-for="link in links"
          :key="link.title"
          :to="link.path"
          color="white"
          flat
      >
        {{ link.title }}
      </v-btn>
      <v-btn color="white" flat @click="redirectTwitter">
        Twitter
      </v-btn>
      <v-flex xs12 py-3 text-xs-center white--text>
        &copy;2018 — <strong>naoki85</strong> — All Rights Reserved.
      </v-flex>
    </v-layout>
  </v-footer>
</template>

<script>
  export default {
    data: () => ({
      links: [
        { title: '利用規約', path: '/user_policy' },
        { title: 'プライバシーポリシー', path: '/privacy_policy' },
      ]
    }),
    methods: {
      redirectTwitter() {
        location.href = 'https://twitter.com/tony_201612';
      }
    }
  }
</script>

<style scoped>

</style>