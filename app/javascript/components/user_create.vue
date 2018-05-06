<template>
  <div>
    <h2>新規登録</h2>
    <p v-if="isError" class="alert alert-danger">登録に失敗しました。登録内容を確認してください。</p>
    <p v-if="isError" class="alert alert-danger">登録が完了しました。</p>
    <div class="row">
      <label for="email">メール</label>
      <input type="email" autofocus="true" autocomplete="email" class="validate" v-model="email">
    </div>
    <div class="row">
      パスワードは最低6文字必要です。
    </div>
    <div class="row">
      <label for="password">パスワード</label>
      <input type="password" autocomplete="off" class="validate" v-model="password">
    </div>
    <div class="row">
      <input type="button" value="登録" @click="onCreate" class="waves-effect waves-teal btn">
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'

  export default {
    data: function() {
      return {
        email: null,
        password: null,
        isError: false,
        isSuccess: false
      }
    },
    methods: {
      onCreate: function () {
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var params = {
          user: {
            email: this.email,
            password: this.password
          }
        };
        request.post('/v1/users', params).then((response) => {
          document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
          this.isSuccess = true;
        }, (error) => {
          console.log(error);
          document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
          this.isError = true;
        });
      }
    }
  }
</script>

<style scoped>

</style>