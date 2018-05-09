<template>
  <div class="container">
    <p v-if="isCreateSuccess" class="alert alert-success">作成完了しました。</p>
    <p v-if="isCreateFailure" class="alert alert-danger">エラーが発生しました。</p>
    <p v-if="isDeleteSuccess" class="alert alert-success">削除が完了しました。</p>
    <p v-if="isDeleteFailure" class="alert alert-danger">エラーが発生しました。</p>
    <h1>{{ book.title }}</h1>

    <div class="row">
      <img :src="book.image_url" :alt="book.title">
    </div>

    <div v-if="loggedIn">
      <div class="row">
        <div class="input-field">
          <label>コメント</label>
          <textarea v-model="newComment" class="materialize-textarea"></textarea>
        </div>
      </div>

      <div class="row right-align">
        <button @click="onCreateComment" class="waves-effect waves-light btn green accent-3">コメント</button>
      </div>
    </div>

    <div v-for="user_book_comment in book.user_book_comments" class="col s12 m8 offset-m2 l6 offset-l3">
      <div class="card-panel z-depth-1" :data-comment-number="user_book_comment.id">
        <div class="row valign-wrapper">
          <div class="col s2">
            <router-link :to="'/users/' + user_book_comment.user.id">
              <img :src="user_book_comment.user.avatar_image_path"
                   :alt="user_book_comment.user.name"
                   class="circle responsive-img">
            </router-link>
          </div>
          <div class="col s9 comment-area">
            <div class="edit-comment-area hidden">
              <div class="input-field">
                <textarea v-model="editComment" class="materialize-textarea"></textarea>
              </div>
              <div class="row">
                <button @click="onEditComment(user_book_comment.id)" class="waves-effect waves-light btn orange accent-3">修正</button>
                <button @click="cancelEdit(user_book_comment.id)" class="waves-effect btn grey lighten-5 black-text">キャンセル</button>
              </div>
            </div>
            <div class="show-comment-area">
              <span class="black-text">{{ user_book_comment.comment }}</span>
              <p class="right-align.grey-text">{{ user_book_comment.created_at }}</p>
            </div>
          </div>
          <div class="col s1">
            <div v-if="canControl(user_book_comment.user.id)">
              <div class="row">
                <a href="javascript:void(0)" @click="enableEdit(user_book_comment.id, user_book_comment.comment)">
                  <i class="material-icons">edit</i>
                </a>
              </div>
              <div class="row">
                <a href="javascript:void(0)" @click="onDeleteComment(user_book_comment.id)">
                  <i class="material-icons">delete</i>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'
  import { mapState } from 'vuex'

  export default {
    data: function() {
      return {
        book: [],
        newComment: '',
        editComment: '',
        isCreateSuccess: false,
        isCreateFailure: false,
        isDeleteSuccess: false,
        isDeleteFailure: false
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn'
      ])
    },
    mounted: function() {
      document.getElementsByClassName('turbolinks-loading')[0].classList.add('active')
      this.fetchBook(this.$route.params.id);
      document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active')
    },
    methods: {
      fetchBook: function(bookId) {
        request.get('/v1/books/' + bookId, {}).then((response) => {
          this.book = response.data.book;
        }, (error) => {
          console.log(error);
        });
      },
      enableEdit: function(userBookCommentId, UserBookCommentComment) {
        var commentArea = document.querySelector('[data-comment-number="' + userBookCommentId + '"]');
        commentArea.querySelector('.show-comment-area').classList.add('hidden');
        commentArea.querySelector('.s1.col').classList.add('hidden');
        commentArea.querySelector('.edit-comment-area textarea').value = UserBookCommentComment;
        commentArea.querySelector('.edit-comment-area').classList.remove('hidden');
      },
      cancelEdit: function(userBookCommentId) {
        var commentArea = document.querySelector('[data-comment-number="' + userBookCommentId + '"]');
        commentArea.querySelector('.show-comment-area').classList.remove('hidden');
        commentArea.querySelector('.s1.col').classList.remove('hidden');
        commentArea.querySelector('.edit-comment-area').classList.add('hidden');
      },
      onCreateComment: function() {
        this.initializeFlags();
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var bookId = this.$route.params.id;
        var newComment = this.newComment;
        var params = { book_id: bookId, comment: newComment };
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.post('/v1/user_book_comments', { params: params, headers: { Authorization: authenticateToken } }).then((response) => {
          this.isCreateSuccess = true;
          this.newComment = '';
          this.book = [];
          this.fetchBook(bookId);
        }, (error) => {
          this.isCreateFailure = true;
          console.log(error);
        });
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
      },
      onEditComment: function(userBookCommentId) {
        this.initializeFlags();
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var editComment = this.editComment;
        var params = { comment: editComment };
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.patch('/v1/user_book_comments/' + userBookCommentId, { params: params, headers: { Authorization: authenticateToken } }).then((response) => {
          this.isCreateSuccess = true;
          this.isEdit = true;
          this.editComment = '';
          var bookId = this.$route.params.id;
          this.book = [];
          this.fetchBook(bookId);
        }, (error) => {
          this.isCreateFailure = true;
          console.log(error);
        });
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
      },
      onDeleteComment: function(userBookCommentId) {
        this.initializeFlags();
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
        request.delete('/v1/user_book_comments/' + userBookCommentId, { headers: { Authorization: authenticateToken } }).then((response) => {
          this.isDeleteSuccess = true;
          var bookId = this.$route.params.id;
          this.book = [];
          this.fetchBook(bookId);
        }, (error) => {
          this.isDeleteFailure = true;
          console.log(error);
        });
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
      },
      initializeFlags: function() {
        this.isCreateSuccess = false;
        this.isCreateFailure = false;
        this.isDeleteSuccess = false;
        this.isDeleteFailure = false;
      },
      canControl: function(commentUserId) {
        if (this.loggedIn) {
          var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
          var userId = authenticateToken.split(':')[0];
          if (userId == commentUserId) {
            return true;
          }
        }
        return false;
      }
    }
  }
</script>

<style scoped>
  .card-panel p {
    margin-top: 18px;
  }

  .hidden {
    display: none;
  }
</style>