<template>
  <v-footer
      dark
      height="auto"
  >
    <v-card
        class="flex"
        flat
        tile
    >
      <v-card-title class="teal">
        <div class="body-2">本ブログは naoki85 によってメンテナンスされています。<br>Twitter などでご意見いただけると嬉しいです。</div>

        <v-spacer></v-spacer>

        <v-btn class="mx-3" dark icon href="https://twitter.com/tony_201612">
          <v-icon size="24px">fab fa-twitter</v-icon>
        </v-btn>
      </v-card-title>

      <v-card-actions class="grey darken-3 justify-center">
        &copy;2018 — <strong>naoki85</strong> — All Rights Reserved.
      </v-card-actions>
    </v-card>
  </v-footer>
</template>