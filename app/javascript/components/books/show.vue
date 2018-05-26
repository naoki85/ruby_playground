<template>
  <v-container fluid>
    <div class="display-1">{{ book.title }}</div>

    <v-layout row>
      <img :src="book.image_url" :alt="book.title">
    </v-layout>

    <div v-if="loggedIn" class="mt-large">
      <div v-if="editFlag">
        <v-layout row wrap>
          <v-flex xs10>
            <v-slider :max="300" v-model="editPage" label="読んだページ"></v-slider>
          </v-flex>
          <v-flex xs2>
            <v-text-field v-model="editPage" type="number"></v-text-field>
          </v-flex>
        </v-layout>

        <v-layout row>
          <v-text-field v-model="editComment" label="コメント"></v-text-field>
        </v-layout>

        <v-btn color="orange white--text" @click="onEditComment">
          編集
          <v-icon color="white">edit</v-icon>
        </v-btn>
        <v-btn @click="cancelEdit">キャンセル</v-btn>
      </div>
      <div v-else>
        <v-layout row wrap>
          <v-flex xs10>
            <v-slider :max="300" v-model="newPage" label="読んだページ"></v-slider>
          </v-flex>
          <v-flex xs2>
            <v-text-field v-model="newPage" type="number"></v-text-field>
          </v-flex>
        </v-layout>

        <v-layout row>
          <v-text-field v-model="newComment" label="コメント"></v-text-field>
        </v-layout>

        <v-btn color="teal white--text" @click="onCreateComment">
          新しいコメント
          <v-icon color="white">add</v-icon>
        </v-btn>
      </div>
    </div>

    <v-expansion-panel class="mt-default">
      <v-expansion-panel-content
          v-for="user_book_comment in book.user_book_comments"
          :key="user_book_comment.id"
          avatar
      >
        <div slot="header">
          <v-layout row>
            <v-flex xs2>
              <v-avatar
                  slot="activator"
                  size="36px"
              >
                <img
                    :src="user_book_comment.user.avatar_image_path"
                    alt="user_book_comment.user.name"
                >
              </v-avatar>
            </v-flex>
            <v-flex xs2>
              {{ user_book_comment.page + ' p' }}
            </v-flex>
            <v-flex xs8>
              <p>{{ user_book_comment.comment }}</p>
              <p class="grey--text">{{ user_book_comment.created_at }}</p>
            </v-flex>
          </v-layout>
        </div>
        <v-card>
          <v-card-text v-if="loggedIn">
            <v-btn
                color="orange white--text"
                @click="enableEdit(user_book_comment.id, user_book_comment.page, user_book_comment.comment)"
            >
              修正
              <v-icon color="white">edit</v-icon>
            </v-btn>
            <v-btn color="red white--text" @click="onDeleteComment(user_book_comment.id)">
              キャンセル
              <v-icon color="white">delete</v-icon>
            </v-btn>
          </v-card-text>
        </v-card>
      </v-expansion-panel-content>
    </v-expansion-panel>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapState, mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        book: [],
        newPage: 0,
        newComment: '',
        editFlag: false,
        editUserBookCommentId: 0,
        editPage: 0,
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
      enableEdit: function(userBookCommentId, UserBookCommentPage, UserBookCommentComment) {
        this.editFlag = true;
        this.editUserBookCommentId = userBookCommentId;
        this.editPage = UserBookCommentPage;
        this.editComment = UserBookCommentComment;
      },
      // 編集をキャンセルする
      cancelEdit: function() {
        this.editFlag = false;
      },
      // コメントを新規作成する
      onCreateComment: function() {
        this.loading();
        var params = { book_id: this.$route.params.id, comment: this.newComment, page: this.newPage };
        request.post('/v1/user_book_comments', { params: params, auth: true })
            .then((response) => {
          this.newComment = '';
          this.newPage = 0;
          this.showSuccessAlert({ message: '作成しました' });
          this.reloadBook(this.$route.params.id);
        }, (error) => {
          this.showErrorAlert({ message: '作成に失敗しました' });
          console.log(error);
        });
        this.finish();
      },
      // コメントを編集する
      onEditComment: function() {
        this.loading();
        var params = { page: this.editPage, comment: this.editComment };
        request.patch('/v1/user_book_comments/' + this.editUserBookCommentId, { params: params, auth: true })
            .then((response) => {
          this.showSuccessAlert({ message: '編集しました' });
          this.editFlag = false;
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
        this.book = [];
        this.fetchBook(this.$route.params.id);
      }
    }
  }
</script>

<style>
  .mt-large {
    margin-top: 50px;
  }
  .mt-default {
    margin-top: 20px;
  }
</style>