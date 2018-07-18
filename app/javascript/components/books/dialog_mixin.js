import BookDialog from './dialog'

export default {
  data: function() {
    return {
      dialog: false,
      dialogBook: {
        title: '',
        detail_page_url: '',
        image_url: ''
      }
    }
  },
  components: {
    'book-dialog': BookDialog
  },
  methods: {
    openDialog(book) {
      this.dialogBook = book;
      this.dialog = true;
    },
    resetDialogParams() {
      this.dialog = false;
      this.dialogBook.title = '';
      this.dialogBook.imageUrl = '';
      this.dialogBook.detailPageUrl = '';
    }
  }
}