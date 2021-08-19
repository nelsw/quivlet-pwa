<template>
  <div
      class="text-center"
  >
    <v-snackbar
        multi-line
        v-model="visible"
    >
      {{ text }}
      <v-btn
          text
          v-text="`Close`"
          color="red"
          @click="$emit('handleClose')"
      />
    </v-snackbar>
  </div>
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