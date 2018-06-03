<template>
  <v-container fluid>
    <div class="display-1">アカウント編集</div>

    <v-form v-model="valid">
      <v-text-field v-model="username" label="UserName"></v-text-field>
      <v-text-field v-model="email" :rules="emailRules" label="Email" required></v-text-field>
      <v-layout row>
        <v-flex xs4 md2>
          <img :src="avatarImagePath" width="100%">
        </v-flex>
        <v-flex xs8 md10>
          <input @change="selectedFile" type="file" name="image">
        </v-flex>
      </v-layout>
      <v-text-field v-model="newPassword" label="新しいパスワード"></v-text-field>
      <v-btn
          :disabled="!valid"
          @click="onUpdate"
      >
        編集
      </v-btn>
    </v-form>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        valid: false,
        username: '',
        email: '',
        avatarImagePath: '',
        image: '',
        newPassword: '',
        emailRules: [
          v => !!v || 'E-mail は必須です',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || '無効な E-mail です'
        ]
      }
    },
    mounted: function() {
      this.loading();
      this.getUserAccount();
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      getUserAccount: function () {
        request.get('/v1/me', { auth: true })
            .then((response) => {
          this.username = response.data.user.name;
          this.email = response.data.user.email;
          this.avatarImagePath = response.data.user.avatar_image_path;
        }, (error) => {
          console.log(error);
        });
      },
      selectedFile: function(e) {
        e.preventDefault();
        let files = e.target.files;
        this.image = files[0];
      },
      onUpdate: function() {
        this.loading();
        let formData = new FormData();
        formData.append('image', this.image);
        formData.append('username', this.username);
        formData.append('email', this.email);
        formData.append('new_password', this.newPassword);
        request.patch('/v1/users/edit', { params: formData,
          headers: { 'content-type': 'multipart/form-data' }, auth: true })
            .then((response) => {
          this.getUserAccount();
        }, (error) => {
          console.log(error);
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>

</style>