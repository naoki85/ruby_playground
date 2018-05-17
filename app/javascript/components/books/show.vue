<template>
  <v-container fluid>
    <div class="display-1">{{ book.title }}</div>

    <v-layout row>
      <img :src="book.image_url" :alt="book.title">
    </v-layout>

    <div v-if="loggedIn" class="new-comment-area">
      <v-layout row>
        <v-text-field v-model="editComment" label="コメント"></v-text-field>
      </v-layout>

      <v-btn @click="onCreateComment">コメント</v-btn>
    </div>

    <v-list two-line subheader>
      <v-list-tile v-for="user_book_comment in book.user_book_comments"
                   :key="user_book_comment.id"
                   class="comment-list"
                   avatar
                   :data-comment-number="user_book_comment.id">
        <v-list-tile-avatar>
          <img :src="user_book_comment.user.avatar_image_path"
               :alt="user_book_comment.user.name">
        </v-list-tile-avatar>
        <v-list-tile-content>
          <div class="edit-comment-area hidden">
              <v-text-field v-model="editComment" class="edit-field"></v-text-field>
              <v-btn @click="onEditComment(user_book_comment.id)">修正</v-btn>
              <v-btn @click="cancelEdit(user_book_comment.id)">キャンセル</v-btn>
          </div>
          <div class="show-comment-area">
            <v-list-tile-title>{{ user_book_comment.comment }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ user_book_comment.created_at }}</v-list-tile-sub-title>
          </div>
        </v-list-tile-content>
        <v-list-tile-action>
          <div>
            <div class="control-area" v-if="canControl(user_book_comment.user.id)">
            <v-btn icon ripple
                   @click="enableEdit(user_book_comment.id, user_book_comment.comment)">
              <v-icon color="grey lighten-1">edit</v-icon>
            </v-btn>
            <v-btn icon ripple
                   @click="onDeleteComment(user_book_comment.id)">
              <v-icon color="grey lighten-1">delete</v-icon>
            </v-btn>
            </div>
          </div>
        </v-list-tile-action>
      </v-list-tile>
      <v-divider></v-divider>
    </v-list>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        book: [],
        newComment: '',
        editComment: ''
      }
    },
    computed: {
      ...mapState('auth', [
        'loggedIn', 'userId'
      ])
    },
    mounted: function() {
      this.loading();
      this.fetchBook(this.$route.params.id);
      this.finish();
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      fetchBook: function(bookId) {
        request.get('/v1/books/' + bookId, {}).then((response) => {
          this.book = response.data.book;
        }, (error) => {
          console.log(error);
          this.$router.push('/not_found');
        });
      },
      // 編集可能にする
      enableEdit: function(userBookCommentId, UserBookCommentComment) {
        var commentArea = document.querySelector('[data-comment-number="' + userBookCommentId + '"]');
        commentArea.querySelector('.show-comment-area').classList.add('hidden');
        commentArea.querySelector('.control-area').classList.add('hidden');
        commentArea.querySelector('.edit-field').value = UserBookCommentComment;
        commentArea.querySelector('.edit-comment-area').classList.remove('hidden');
      },
      // 編集をキャンセルする
      cancelEdit: function(userBookCommentId) {
        var commentArea = document.querySelector('[data-comment-number="' + userBookCommentId + '"]');
        commentArea.querySelector('.show-comment-area').classList.remove('hidden');
        commentArea.querySelector('.control-area').classList.remove('hidden');
        commentArea.querySelector('.edit-comment-area').classList.add('hidden');
      },
      // コメントを新規作成する
      onCreateComment: function() {
        this.loading();
        var bookId = this.$route.params.id;
        var newComment = this.newComment;
        var params = { book_id: bookId, comment: newComment };
        request.post('/v1/user_book_comments', { params: params, auth: true })
            .then((response) => {
          this.newComment = '';
          this.showSuccessAlert({ message: '作成しました' });
          this.reloadBook(bookId);
        }, (error) => {
          this.showErrorAlert({ message: '作成に失敗しました' });
          console.log(error);
        });
        this.finish();
      },
      // コメントを編集する
      onEditComment: function(userBookCommentId) {
        this.loading();
        var editComment = this.editComment;
        var params = { comment: editComment };
        request.patch('/v1/user_book_comments/' + userBookCommentId, { params: params, auth: true })
            .then((response) => {
          this.showSuccessAlert({ message: '編集しました' });
          this.editComment = '';
          this.reloadBook();
        }, (error) => {
          this.showErrorAlert({ message: '編集失敗しました' });
          console.log(error);
        });
        this.finish();
      },
      onDeleteComment: function(userBookCommentId) {
        this.loading();
        request.delete('/v1/user_book_comments/' + userBookCommentId, { auth: true })
            .then((response) => {
          this.showSuccessAlert({ message: '削除しました' });
          this.reloadBook();
        }, (error) => {
          this.showErrorAlert({ message: '削除失敗しました' });
          console.log(error);
        });
        this.finish();
      },
      reloadBook: function() {
        var bookId = this.$route.params.id;
        this.book = [];
        this.fetchBook(bookId);
      },
      canControl: function(commentUserId) {
        if (this.loggedIn && this.userId) {
          if (this.userId == commentUserId) {
            return true;
          }
        }
        return false;
      }
    }
  }
</script>

<style>
  .hidden {
    display: none;
  }
  .new-comment-area {
    margin-top: 50px;
  }
  .edit-comment-area {
    width: 100%;
  }
  .comment-list > div {
    height: 150px !important;
  }
</style>