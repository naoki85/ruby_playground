<template>
  <nav class="nav-extended">
    <div class="nav-wrapper container">
      <a href="/" class="brand-logo">BookRecorder</a>
      <a data-activates="slide-out" class="button-collapse hide-on-large-only">
        <i class="material-icons">menu</i>
      </a>
      <ul v-if="loggedIn" class="right hide-on-med-and-down">
        <li><a href="/users/edit">アカウント編集</a></li>
        <li><a href="/books/search">本を探す</a></li>
        <li><a href="/user_books">本棚</a></li>
        <li><a href="/users/sign_out">ログアウト</a></li>
      </ul>
      <ul v-else class="right hide-on-med-and-down">
        <li><router-link to="/users/sign_in">ログイン</router-link></li>
      </ul>
      <ul v-if="loggedIn" id="slide-out" class="side-nav">
        <li><a href="/users/edit">アカウント編集</a></li>
        <li><a href="/books/search">本を探す</a></li>
        <li><a href="/user_books">本棚</a></li>
        <li><a href="/users/sign_out">ログアウト</a></li>
      </ul>
      <ul v-else id="slide-out" class="side-nav">
        <li><router-link to="/users/sign_in">ログイン</router-link></li>
      </ul>
    </div>
  </nav>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    }
  }
</script>

<style scoped>

</style>