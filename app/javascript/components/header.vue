<template>
  <nav class="nav-extended">
    <div class="nav-wrapper container">
      <router-link to="/" class="brand-logo">BookRecorder</router-link>
      <a data-activates="slide-out" class="button-collapse hide-on-large-only" @click="showSidenav">
        <i class="material-icons">menu</i>
      </a>
      <ul v-if="loggedIn" class="right hide-on-med-and-down">
        <li><router-link to="/users/edit">アカウント編集</router-link></li>
        <li><router-link to="/books/search">本を探す</router-link></li>
        <li><router-link to="/user_books">本棚</router-link></li>
        <li><a href="javascript:void(0)" @click="onLogout">ログアウト</a></li>
      </ul>
      <ul v-else class="right hide-on-med-and-down">
        <li><router-link to="/sign_in">ログイン</router-link></li>
      </ul>
      <ul v-if="loggedIn" id="slide-out" class="side-nav">
        <li><router-link to="/users/edit">アカウント編集</router-link></li>
        <li><router-link to="/books/search">本を探す</router-link></li>
        <li><router-link to="/user_books">本棚</router-link></li>
        <li><a href="javascript:void(0)" @click="onLogout">ログアウト</a></li>
        <li><a href="javascript:void(0)" @click="hiddenSidenav">サイドバーを閉じる</a></li>
      </ul>
      <ul v-else id="slide-out" class="side-nav">
        <li><router-link to="/sign_in">ログイン</router-link></li>
        <li><a href="javascript:void(0)" @click="hiddenSidenav">サイドバーを閉じる</a></li>
      </ul>
    </div>
  </nav>
</template>

<script>
  import request from '../utils/requests'
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    methods: {
      // TODO: とりあえずで作成...
      showSidenav: function() {
        document.getElementById("slide-out").style.transform = "translateX(0px)";
      },
      hiddenSidenav: function() {
        document.getElementById("slide-out").style.transform = "translateX(-100%)";
      },
      onLogout: function() {
        request.delete('/v1/logout', { auth: true }).then((response) => {
          location.href = '/';
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style scoped>

</style>