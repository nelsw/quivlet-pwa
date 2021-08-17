<template>
  <v-dialog
      persistent
      hide-overlay
      width="300"
      v-model="dialog"
  >
    <v-card
        color="primary"
    >
      <v-card-text>
        <span
            v-text="message"
        />
        <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
        />
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  namespaced: true,
  props: {
    dialog: Boolean,
    message: String,
  },
}
</script>