<template>
  <v-overlay :value="overlay">
    <v-progress-circular
        indeterminate
        size="64"
    />
  </v-overlay>
</template>

<script>
export default {
  namespaced: true,
  props:{
    overlay: Boolean,
  },
}
</script>