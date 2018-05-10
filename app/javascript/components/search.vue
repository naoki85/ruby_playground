<template>
  <div class="container">
    <p v-if="isError" class="alert alert-danger">エラーが発生しました。再度お試しください。</p>
    <p v-if="isCreated" class="alert alert-success">本棚に追加しました。</p>
    <h1>本を探す</h1>
    <div class="row">
      <div class="input-field">
        <label>キーワード</label>
        <input v-model="keyword" type="text" autofocus="sutofocus">
      </div>
    </div>
    <div class="row">
      <button @click="onBookSearch" class="waves-effect btn grey lighten-5 black-text">探す</button>
    </div>
    <div v-if="isLoading" class="progress"><div class="indeterminate"></div></div>
    <div v-for="item in items" class="row">
      <div class="col s12">
        <div class="card horizontal">
          <div class="card-image">
            <img :src="item.small_image_url" alt="item.title">
          </div>
          <div class="card-stacked">
            <div class="card-content">
              <p>{{ item.title }}</p>
              <p>{{ item.author }}</p>
            </div>
            <div class="card-action">
              <button @click="onAddBook(item)" class="waves-effect btn grey lighten-5 black-text">追加</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'

  export default {
    data: function() {
      return {
        isError: false,
        isCreated: false,
        isLoading: false,
        keyword: '',
        items: []
      }
    },
    methods: {
      onBookSearch() {
        if (!this.keyword) {
          this.isError = true;
          return;
        }
        this.items = [];
        this.isError = false;
        this.isLoading = true;
        this.isCreated = false;
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.get('/v1/books/search',
            { params: { keyword: this.keyword }, headers: { Authorization: authenticateToken } }).
        then((response) => {
          if (response.data.results) {
            this.items = response.data.results;
          } else {
            this.isError = true;
          }
          this.isLoading = false;
        }, (error) => {
          console.log(error);
        });
      },
      onAddBook(book) {
        if (!book) {
          this.isError = true;
          return;
        }
        this.isError = false;
        this.isCreated = false;
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.post('/v1/user_books',
            { params: { user_book: book }, headers: { Authorization: authenticateToken } }).
        then((response) => {
          this.isCreated = true;
        }, (error) => {
          console.log(error);
        });
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active')
      }
    }
  }
</script>

<style scoped>

</style>