<template>
  <div>
    <v-navigation-drawer v-model="drawer" fixed app>
      <v-list v-if="loggedIn" dense>
        <v-list-tile to="/">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Home</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/users/edit">
          <v-list-tile-action>
            <v-icon>account_circle</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>アカウント編集</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/posts/new">
          <v-list-tile-action>
            <v-icon>create</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>記事作成</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/user_books">
          <v-list-tile-action>
            <v-icon>library_books</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>本棚</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/books/search">
          <v-list-tile-action>
            <v-icon>search</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>本を探す</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile @click="onLogout">
          <v-list-tile-action>
            <v-icon>exit_to_app</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>ログアウト</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
      <v-list v-else dense>
        <v-list-tile to="/">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Home</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/posts">
          <v-list-tile-action>
            <v-icon>library_books</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>ブログ</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/sign_in">
          <v-list-tile-action>
            <v-icon>exit_to_app</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>ログイン</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <!--<v-list-tile to="/sign_up">-->
          <!--<v-list-tile-action>-->
            <!--<v-icon>exit_to_app</v-icon>-->
          <!--</v-list-tile-action>-->
          <!--<v-list-tile-content>-->
            <!--<v-list-tile-title>新規登録</v-list-tile-title>-->
          <!--</v-list-tile-content>-->
        <!--</v-list-tile>-->
      </v-list>
    </v-navigation-drawer>
    <v-toolbar color="teal" dark fixed app>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title>BookRecorder</v-toolbar-title>
    </v-toolbar>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'

  export default {
    data: () => ({
      drawer: null
    }),
    props: {
      source: String
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    methods: {
      ...mapActions('auth', [
        'logout'
      ]),
      onLogout: function() {
        this.logout({
          router: this.$router,
          data: this.$data
        });
      }
    }
  }
</script>

<style scoped>

</style>