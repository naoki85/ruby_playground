<template>
  <v-dialog
      v-model="dialog"
      width="500"
      persistent
  >
    <v-card>
      <v-card-title
          class="headline grey lighten-2"
          primary-title
      >
        {{ title }}
      </v-card-title>

      <v-card-text>
        <div width="100%" class="text-xs-center">
          <img :src="imageUrl" :alt="title" class="dialog-image">
        </div>
      </v-card-text>

      <v-divider></v-divider>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
            color="primary"
            flat
            @click="redirectDetailPage(detailPageUrl)"
        >
          公式ページに移動
        </v-btn>
        <v-btn
            color="primary"
            flat
            @click="closeDialog"
        >
          Close
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
  export default {
    props: {
      dialog: {
        type: Boolean,
        default: false
      },
      title: {
        type: String,
        default: ''
      },
      imageUrl: {
        type: String,
        default: ''
      },
      detailPageUrl: {
        type: String,
        default: ''
      }
    },
    methods: {
      redirectDetailPage(url) {
        location.href = url;
      },
      closeDialog() {
        this.$emit('close-dialog');
      }
    }
  };
</script>

<style scoped>
  .dialog-image {
    max-width: 100%;
    max-height: 400px;
  }
</style>