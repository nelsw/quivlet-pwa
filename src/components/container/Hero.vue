<template>
  <v-container
      v-show="show"
  >
    <v-row
        class="text-center"
    >
      <v-col
          cols="12"
      >
        <v-img
            contain
            class="my-3"
            height="200"
            :src="require('../../assets/logo.svg')"
        />
      </v-col>
      <v-col
          class="mb-4"
      >
        <h1
            class="display-2 font-weight-bold mb-3"
            v-text="`Welcome to Quivlet`"
        />
        <p class="subheading font-weight-regular">
          Broad topic trivia contests;
          <br>
          Correct answers advance;
          <br>
          Free to play.
        </p>
      </v-col>
      <v-col
          class="mb-5"
          cols="12"
      >
        <h2
            class="headline font-weight-bold mb-3"
            v-text="`... are you game?`"
        />
        <br>
        <v-btn
            x-large
            color="primary"
            v-text="`Let's Play!`"
            @click="dialog = true"
        />
      </v-col>
    </v-row>
    <Dialog
        :dialog="dialog"
        @handleOk="$emit('handleOk'); dialog = false"
        @handleCancel="dialog = false"
    />
  </v-container>
</template>

<script>
import Dialog from "@/components/dialog/UserDialog";
export default {
  namespaced: true,
  components: {Dialog},
  props: {
    show: Boolean,
  },

  data: () => ({
    dialog: false,
  }),
}
</script>
