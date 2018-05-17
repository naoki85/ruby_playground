<template>
  <div class="container">
    <h2>アカウント編集</h2>

    <form enctype="multipart/form-data" name="userEditForm">
      <div class="row">
        <div class="input-field">
          <label>username</label>
          <input type="text" name="username" autofocus="autofocus" class="validate"
                 v-model="username">
        </div>
      </div>
      <div class="row">
        <img :src="user.avatar_image_path" :alt="user.name">
      </div>
      <div class="row">
        <label>file</label>
        <input type="file" name="image">
      </div>
      <div class="row">
        <div class="input-field">
          <label>email</label>
          <input type="email" name="email" autofocus="autofocus" autocomplete="email" class="validate"
                 v-model="email">
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <label>パスワード</label>
          <input type="password" name="new_password"autocomplete="off">
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <label>現在のパスワード</label>
          <input type="password" name="password"autocomplete="off">
        </div>
      </div>
      <div class="row">
        <button @click="updateUserAccount" class="waves-effect waves-light btn orange accent-3">編集</button>
      </div>
    </form>
  </div>
</template>

<script>
  import request from '../../utils/requests'

  export default {
    data: function() {
      return {
        username: null,
        email: null,
        isError: false,
        isSuccess: false,
        user: []
      }
    },
    mounted: function() {
      this.getUserAccount();
    },
    methods: {
      getUserAccount: function () {
        request.get('/v1/user/account', { auth: true }).then((response) => {
          this.user = response.data.user;
        }, (error) => {
          console.log(error);
        });
      },
      updateUserAccount: function() {
        this.initData();
        var form = document.forms.namedItem("userEditForm");
        var params = new FormData(form);
        request.patch('/v1/users/' + this.user.id, { params: params, auth: true }).then((response) => {
          this.user = response.data.user;
          this.isSuccess = true;
        }, (error) => {
          console.log(error);
          this.isError = true;
        });
      },
      initData: function() {
        this.isSuccess = false;
        this.isError = false;
      }
    }
  }
</script>

<style scoped>

</style>