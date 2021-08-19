<template>
  <v-dialog
      persistent
      hide-overlay
      width="300"
      v-model="visible"
  >
    <v-card
        color="primary"
    >
      <v-card-text>
        <span
            v-text="text"
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
    visible: Boolean,
    text: String,
  },
}
</script>